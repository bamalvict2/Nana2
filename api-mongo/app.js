require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const path = require('path');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const verifyToken = require('./middlewares/auth');
const rappelsRoutes = require('./routes/rappels');
const authRoutes = require('./routes/auth');
const eparvierRoutes = require('./routes/eparviers');

const Rappel = require('./models/rappel');
const Utilisateur = require('./models/utilisateur');
const Eparvier = require('./models/eparvier');

const app = express(); // 👈 doit venir avant les app.use()

// 🧱 Middlewares globaux
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// 🔗 Routes API
app.use('/auth', authRoutes);
app.use('/rappels', rappelsRoutes);
app.use('/eparviers', eparvierRoutes);

// 🧭 Routes HTML
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'public', 'index.html')));
app.get('/login', (req, res) => res.sendFile(path.join(__dirname, 'public', 'login.html')));
app.get('/dashboard', (req, res) => res.sendFile(path.join(__dirname, 'public', 'dashboard.html')));
app.get('/eparvier', verifyToken, (req, res) => res.sendFile(path.join(__dirname, 'public', 'eparvier.html')));
app.get('/api', (req, res) => res.json({ message: 'API Nana fonctionne ✅' }));

module.exports = app;