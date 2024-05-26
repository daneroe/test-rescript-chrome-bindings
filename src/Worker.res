open Promise

Chrome.runtimeOnInstall(_ => {
  Console.log("Initialising state then retrieving it")
  Chrome.setLocalStorage({state: "My State Value"})
  ->thenResolve(_ => Chrome.getLocalStorage("state")->thenResolve(res => Console.log(res.state)))
  ->ignore // need this as have indicated in the bindings that these callbacks return unit (F#-y)
})

Chrome.navigationOnComplete(navEvent => {
  Console.log("Naving")
  Console.log(navEvent)
})

Chrome.tabsOnActivated(tabInfo => {
  Console.log("Tabbing")
  Console.log(tabInfo)
})

Chrome.tabsOnRemoved((id, tabRemoveInfo) => {
  Console.log("Closing")
  Console.log(id)
  Console.log(tabRemoveInfo)
})
