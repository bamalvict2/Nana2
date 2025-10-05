require('dotenv').config();
const mongoose = require('mongoose');
const app = require('./app');

const port = process.env.PORT || 3000;
const mongoUri = process.env.MONGO_URI || 'mongodb://localhost:27017/nana';

mongoose.connect(mongoUri)
  .then(() => {
    console.log('✅ Connexion MongoDB réussie');
    app.listen(port, () => {
      console.log(`🚀 API Nana en ligne sur http://localhost:${port}`);
    });
  })
  .catch(err => {
    console.error('❌ Erreur Mongo :', err);
  });