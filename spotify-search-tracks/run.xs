run.job "Spotify Search Tracks" {
  main = {
    name: "search_tracks"
    input: {
      query: "Never Gonna Give You Up"
      limit: 5
      access_token: ""
    }
  }
  env = ["spotify_access_token"]
}
