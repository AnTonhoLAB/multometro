const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.apagaLA = functions.database.ref('/user').onCreate((snap, context) => {
    
    const newValue = snap.data();
    newValue.first = "George";
    residentRef.doc(savedUserDoc.id).set(user)
    
});

exports.webhook = functions
    .https.onRequest((req, res) => {
            res.send("Hello");
    });

exports.addGeorge = functions.https.onRequest((req, res) => {
    try {
        const userCollection = admin.firestore().collection("user");
        const user = {
            name: "George",
            idade: 23
        };
        userCollection.add(user);

    } catch (error) {
        console.log('Failed to registerBuilding:', error);
        return error;
    }
});



    
  
