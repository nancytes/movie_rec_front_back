const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { exec } = require('child_process');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Endpoint to handle recommendations
app.post('/recommend', (req, res) => {
  const preferences = req.body.preferences;

  // Check if preferences are provided
  if (!preferences || preferences.length === 0) {
    return res.status(400).json({ error: 'No preferences provided.' });
  }

  // Construct the Prolog query
  const prologQuery = `recommend(${preferences.join(', ')}, Recommendations).`;

  
  exec(`swipl -g "${prologQuery}" -t halt movies.pl`, (error, stdout, stderr) => {
    if (error) {
      console.error('Error executing Prolog query:', stderr);
      return res.status(500).json({ error: 'Failed to fetch recommendations from Prolog server.' });
    }

    // Parse the Prolog output
    const recommendations = stdout
      .split('\n')
      .filter(line => line.trim() !== '')
      .map(line => line.replace(/'/g, '')); // Remove quotes from movie names

    // Send the recommendations back to the frontend
    res.json({ recommendations });
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Backend server running on http://localhost:${PORT}`);
});