const mongoose = require('mongoose');

const RappelSchema = new mongoose.Schema({
  titre: String,
  contenu: String,
  date: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Rappel', RappelSchema);