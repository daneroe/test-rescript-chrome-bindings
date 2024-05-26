module ChromeTypes = {
  type activeInfo = {
    tabId: int,
    windowId: int,
  }

  type navEvent = {
    documentId: string,
    documentLifecycle: string,
    frameId: int,
    parentDocumentId: string,
    parentFrameId: int,
    processId: int,
    tabId: int,
    timeStamp: float,
    url: string,
  }

  type tabRemoveInfo = {
    isWindowClosing: bool,
    windowId: int,
  }

  type stateKv = {state: string}
}
