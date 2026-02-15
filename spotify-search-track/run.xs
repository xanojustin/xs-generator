run.job "Spotify Search Track" {
  main = {
    name: "search_track"
    input: {
      query: "Never Gonna Give You Up"
      limit: 5
      market: "US"
    }
  }
  env = ["SPOTIFY_CLIENT_ID", "SPOTIFY_CLIENT_SECRET"]
}
