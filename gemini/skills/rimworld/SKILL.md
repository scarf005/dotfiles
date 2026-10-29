---
name: rimworld
description: Guidelines and instructions for RimWorld mod development, decompiling, Harmony patching, and Quest signal mechanics.
---

# RimWorld Modding Guidelines

This skill documents critical constraints, architectural patterns, and debugging steps for developing and patching C# / F# mods in RimWorld.

## 1. Harmony Patching Constraints

### Yield Return (Deferred Evaluation)
*   **Problem**: Methods utilizing `yield return` return an compiler-generated state machine (`IEnumerable<T>`). Modifying the `__result` reference in a Harmony `Postfix` patch will fail because the caller has already retrieved the enumerator reference.
*   **Solution**: Use a **`Prefix`** patch instead. Set the `__result` to a fully evaluated custom collection (e.g., converted to a list) and return `false` to block vanilla execution.

### Lost Instance References (`__instance` is null)
*   **Problem**: In complex lambda contexts (e.g., float menus with delegates), the Harmony `__instance` parameter representing the target action (`this` pointer) can resolve to `null` at runtime.
*   **Solution**: Never rely on `__instance` in float menu action handlers if it is susceptible to compiler wrapping. Explicitly instantiate the target class (e.g., `new TransportersArrivalAction_GiveGift(settlement)`) using valid contextual variables and pass it to the launcher helper.

---

## 2. Quest & Signal Mechanics

### Signal Transmissions via QuestUtility
*   **Problem**: Using `Find.SignalManager.SendSignal` with a raw string tag does not fulfill vanilla quests because the quest state machine expects complex signals linked to specific `questTags` and parameter bindings.
*   **Solution**: Use **`RimWorld.QuestUtility.SendQuestTargetSignals`** with the appropriate parent `questTags` and target parameters:
    ```csharp
    QuestUtility.SendQuestTargetSignals(parent.questTags, "TradeRequestFulfilled", new NamedArgument(parent, "SUBJECT"));
    ```

### Hardcoded Signal Constants
*   **Problem**: Vanilla trade quests (`TradeRequestComp`) do not rely on dynamic strings in `outSignalFulfilled` fields at completion.
*   **Solution**: The completion signal part must be the exact compile-time constant **`"TradeRequestFulfilled"`** to properly trigger quest nodes like `QuestPart_GiveToCaravan`.

---

## 3. Disassembly & Static Analysis via Reflection

When decompilers are missing on the target system, compile-time details must be resolved dynamically. Use direct IL byte parsing via .NET Reflection to examine method implementations:

```fsharp
let body = targetMethod.GetMethodBody()
let il = body.GetILAsByteArray()
// Walk IL bytes to parse call instructions (0x28, 0x6F) and resolve metadata tokens
```
Always analyze the binary truth of target assemblies rather than guessing the behavior from class structures.
