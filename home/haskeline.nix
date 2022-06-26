{ ... }:

{
  home.file.".haskeline".text = ''
    editMode: Vi
    completionType: MenuCompletion
    maxHistorySize: Just 40
    listCompletionsImmediately: True
    historyDuplicated: IgnoreAll
  '';
}
