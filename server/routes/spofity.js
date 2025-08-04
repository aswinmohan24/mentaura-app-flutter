const express = require("express");
const verifyFirebaseToken = require("../middleware/auth.middleware");
const axios = require("axios");
const moodQueryMap = require("../spotify_query");

const spotifyRouter = express.Router();



// Step 1: Get Spotify access token using Client Credentials Flow
async function getSpotifyToken() {
  const { SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET } = process.env;
  const credentials = Buffer.from(`${SPOTIFY_CLIENT_ID}:${SPOTIFY_CLIENT_SECRET}`).toString('base64');

  const response = await axios.post(
    'https://accounts.spotify.com/api/token',
    new URLSearchParams({ grant_type: 'client_credentials' }),
    {
      headers: {
        Authorization: `Basic ${credentials}`,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    }
  );

  return response.data.access_token;
}

function getRandomQuery(mood, type) {
  const moodSet = moodQueryMap[mood.toLowerCase()];
  if (!moodSet || !moodSet[type]) return encodeURIComponent(mood); // fallback

  const options = moodSet[type];
  const query = options[Math.floor(Math.random() * options.length)];
  return encodeURIComponent(query);
}

async function searchSpotifyContent(mood, token) {
  const playlistQuery = getRandomQuery(mood, "playlist");
  const podcastQuery = getRandomQuery(mood, "podcast");
  const language = encodeURIComponent("english");

  const offset = Math.floor(Math.random() * 5);

  const playlistRes = await axios.get(
    `https://api.spotify.com/v1/search?q=${playlistQuery}&type=playlist&limit=1&offset=${offset}`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );

  const podcastRes = await axios.get(
    `https://api.spotify.com/v1/search?q=${podcastQuery}&type=show&limit=10`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );

  const playlist = playlistRes.data.playlists.items[0];
  const englishShows = podcastRes.data.shows.items.filter(show =>
    show.languages?.includes('en')
  );
  const podcast = englishShows[Math.floor(Math.random() * englishShows.length)];

  return {
    mood,
    playlist: playlist
      ? {
          name: playlist.name,
          url: playlist.external_urls.spotify,
          image: playlist.images[0]?.url,
          description: playlist.description,
        }
      : null,
    podcast: podcast
      ? {
          name: podcast.name,
          publisher: podcast.publisher,
          url: podcast.external_urls.spotify,
          image: podcast.images[0]?.url,
          description: podcast.description,
        }
      : null,
  };
}



// Step 3: API Endpoint to get playlist + podcast by mood
spotifyRouter.get('/api/v1/spotify/recommendation/:mood', verifyFirebaseToken, async (req, res) => {
  const mood = req.params.mood;

  try {
    const token = await getSpotifyToken();
    const result = await searchSpotifyContent(mood, token);
    res.status(200).json({success : true, data : result});
  } catch (err) {
    console.error(err.response?.data || err.message);
    res.status(500).json({ error: 'Failed to get recommendations' });
  }
});

module.exports = spotifyRouter;