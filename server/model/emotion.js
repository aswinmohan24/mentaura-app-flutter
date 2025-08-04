const mongoose = require("mongoose");

const emotionSchema = mongoose.Schema({

    emotion : {
        type : String,
        required : true
    },

    confidence : {
        type : Number,
        required : true
    },

    chatTitle : {
        type : String,
        required : true
    },
    suggestedReplyTitle : {
        type : String,
        required : true
    },
    suggestedReply : {
        type : String,
        required : true
    },

    activityTitle:  {
        type : String,
        required : true
    },

    explanation : {
        type : String,
        required : true
    },
    createdDateTime: {
        type: Date,
        required : true
        
     },
     userMessage : {
        type : String,
        required : true
     },
     firebaseUid : {
        type : String,
        required : true,
        unique : false
       
    }

});

const Emotion  = mongoose.model("EmotionDetections", emotionSchema);

module.exports = Emotion;