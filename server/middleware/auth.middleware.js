const admin = require('firebase-admin');


// middleware for firebase user authorization
const verifyFirebaseToken = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({success : false, message: 'User is not authenticated' });
  }
  const idToken = authHeader.replace(/^Bearer\s+/, '');

  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    req.firebaseUid = decodedToken.uid;
    next();
  } catch (error) {
    return res.status(401).json({ message: 'Unauthorized - Invalid token', error });
  }
};

module.exports = verifyFirebaseToken;