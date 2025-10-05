const mongoose = require('mongoose');

const eparvierSchema = new mongoose.Schema({
  nom: { type: String, required: true },
  espece: { type: String, required: true },
  dateObservation: { type: Date, default: Date.now },
  localisation: { type: String },
  notes: { type: String }
});

module.exports = mongoose.model('Eparvier', eparvierSchema);