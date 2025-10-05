const jwt = require('jsonwebtoken');

function verifyToken(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(403).json({ message: 'Token manquant ❌' });
  }

  const token = authHeader.split(' ')[1];
  jwt.verify(token, process.env.SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: 'Token invalide ❌' });
    }

    req.userId = decoded.id; // Tu peux utiliser ça dans tes routes si besoin
    next(); // Passe à la route suivante
  });
}

module.exports = verifyToken;

