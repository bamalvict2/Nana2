const mongoose = require('mongoose');

const rappelSchema = new mongoose.Schema({
  titre: { type: String, required: true },
  contenu: { type: String, required: true },
  date: { type: Date, default: Date.now },
  utilisateurId: { type: mongoose.Schema.Types.ObjectId, ref: 'Utilisateur' }
});

module.exports = mongoose.model('Rappel', rappelSchema);