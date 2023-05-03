enum LoadingState {
  //initial state: initial screen state
  init,
  //loading state: set if you are waiting for api or cache to finish, used to show loading indicator
  loading,
  //loaded state: set if loading is done
  loaded,
  //error state: set if an error occurred to show error dialog or snackbar
  error,
}