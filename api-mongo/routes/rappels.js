const express = require('express');
const Rappel = require('../models/rappel');

const router = express.Router();

router.get('/', async (req, res) => {
  const rappels = await Rappel.find();
  res.json(rappels);
});

router.post('/', async (req, res) => {
  const nouveau = new Rappel(req.body);
  const saved = await nouveau.save();
  res.status(201).json(saved);
});

module.exports = router;