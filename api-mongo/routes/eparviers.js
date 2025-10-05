const express = require('express');
const Eparvier = require('../models/eparvier');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const data = await Eparvier.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({ message: 'Erreur serveur', erreur: err });
  }
});

router.post('/', async (req, res) => {
  try {
    const nouveau = new Eparvier(req.body);
    const saved = await nouveau.save();
    res.status(201).json(saved);
  } catch (err) {
    res.status(500).json({ message: 'Erreur serveur', erreur: err });
  }
});

module.exports = router;