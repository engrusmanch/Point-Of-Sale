enum LoadingState {
  loading,
  loaded,
  error;

  bool get isLoaded =>
      this == LoadingState.loaded;
}
