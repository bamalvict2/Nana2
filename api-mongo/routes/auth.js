const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Utilisateur = require('../models/utilisateur');

const router = express.Router();

// ➕ Création d'utilisateur
router.post('/utilisateurs', async (req, res) => {
  try {
    const nouvelUtilisateur = new Utilisateur(req.body);
    await nouvelUtilisateur.save();
    res.status(201).json({
      message: 'Utilisateur créé ✅',
      user: { username: nouvelUtilisateur.username }
    });
  } catch (err) {
    console.error('❌ Erreur création utilisateur:', err); // 👀 log utile pour debug
    res.status(500).json({ message: 'Erreur serveur', erreur: err });
  }
});

// 🔐 Connexion
router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await Utilisateur.findOne({ username });
    if (!user) return res.status(401).json({ message: 'Utilisateur introuvable ❌' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(401).json({ message: 'Mot de passe incorrect ❌' });

    const token = jwt.sign({ id: user._id }, process.env.SECRET_KEY, { expiresIn: '1h' });
    res.json({
      message: 'Connexion réussie ✅',
      token,
      user: { username: user.username }
    });
  } catch (err) {
    console.error('❌ Erreur connexion utilisateur:', err); // 👀 log utile pour debug
    res.status(500).json({ message: 'Erreur serveur', erreur: err });
  }
});

module.exports = router;