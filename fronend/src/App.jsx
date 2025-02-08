import React, { useState } from 'react';
import axios from 'axios';
import './index.css';

function App() {
  const [preferences, setPreferences] = useState({ genre: '', language: '', year: '', age: '', actor: '', rating: '' });
  const [recommendations, setRecommendations] = useState([]);
  const [error, setError] = useState('');

  const handleChange = (e) => {
    setPreferences({ ...preferences, [e.target.name]: e.target.value });
  };

  const getRecommendations = async () => {
    // Validate rating
    if (preferences.rating > 10 || preferences.rating < 0) {
      setError('Rating must be between 1 and 10.');
      return;
    }

    // Prepare preferences for the backend
    const selectedPreferences = Object.entries(preferences)
      .filter(([key, value]) => value)
      .map(([key, value]) => `${key}(${value})`);

    // Check if at least one preference is selected
    if (selectedPreferences.length === 0) {
      setError('Please select at least one preference.');
      return;
    }

    setError('');
    try {
      // Send preferences to the backend
      const response = await axios.post('http://localhost:3000/recommend', {
        preferences: selectedPreferences,
      });
      setRecommendations(response.data.recommendations);
    } catch (error) {
      console.error('Error fetching recommendations', error);
      setError('Failed to fetch recommendations. Please check the backend and Prolog server.');
    }
  };

  return (
    <div className="app-container">
      <div className="form-container">
        <h1 className="title">🎥 Movie Recommendation System 🎬</h1>
        <div className="input-group">
          <select name="genre" className="input" onChange={handleChange}>
            <option value="">Select Genre</option>
            <option value="scifi">Sci-Fi</option>
            <option value="thriller">Thriller</option>
            <option value="crime">Crime</option>
            <option value="animation">Animation</option>
            <option value="action">Action</option>
          </select>

          <select name="language" className="input" onChange={handleChange}>
            <option value="">Select Language</option>
            <option value="english">English</option>
            <option value="korean">Korean</option>
            <option value="japanese">Japanese</option>
          </select>

          <input type="text" name="year" placeholder="Year (e.g., 2010)" className="input" onChange={handleChange} />
          <input type="number" name="age" placeholder="Your Age" className="input" onChange={handleChange} />
          <input type="text" name="actor" placeholder="Favorite Actor (e.g., Leonardo DiCaprio)" className="input" onChange={handleChange} />
          <input type="number" name="rating" placeholder="Minimum Rating (1-10)" className="input" onChange={handleChange} />

          {error && <p className="error-message">{error}</p>}

          <button onClick={getRecommendations} className="submit-button">🔍 Get Recommendations</button>
        </div>

        <div className="recommendations">
          <h2 className="recommendations-title">Recommended Movies:</h2>
          <ul className="recommendations-list">
            {recommendations.length > 0 ? (
              recommendations.map((movie, index) => <li key={index} className="recommendation-item">{movie}</li>)
            ) : (
              <li>No recommendations yet. Please provide preferences.</li>
            )}
          </ul>
        </div>
      </div>
    </div>
  );
}

export default App;