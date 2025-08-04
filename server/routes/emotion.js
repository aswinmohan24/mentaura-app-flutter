const express = require("express");
const verifyFirebaseToken = require("../middleware/auth.middleware");
const Emotions = require("../model/emotion");

const emotionRouter = express.Router();

emotionRouter.post("/api/v1/createemotion", verifyFirebaseToken, async(req, res)=>{

 try {
        const firebaseUid = req.firebaseUid;
    const newEmotion =  new Emotions({
        ...req.body,
        firebaseUid
    });

   const savedEmotion = await newEmotion.save();
   return res.status(201).json({success : true , data : savedEmotion._id});
    
 } catch (error) {
    console.error(`Error occurred when creating new emotion document:`, error);
    return res.status(500).json({success : false, message : "Internal Server error"})
    
 }

});

emotionRouter.get("/api/v1/getemotions", verifyFirebaseToken, async(req, res) =>{

    try {
    const firebaseUid = req.firebaseUid;
    const allEmotions =  await Emotions.find({firebaseUid});
    if (allEmotions.length === 0) {
  return res.status(404).json({ success: true, date: [] });
}
  return res.status(200).json({success : true, data : allEmotions});
    } catch (error) {
console.error("Error fetching emotions history", error);
return res.status(500).json({success : false, message : "Internal server error"});

    }
});

emotionRouter.delete("/api/v1/deleteemotion/:id", verifyFirebaseToken, async (req, res) => {
  try {
    const firebaseUid = req.firebaseUid; 
    const emotionId = req.params.id;    
    const emotion = await Emotions.findOne({ _id: emotionId, firebaseUid });
    if (!emotion) {
      return res.status(404).json({ success: false, message: "Emotion History not found or unauthorized" });
    }

    await Emotions.deleteOne({ _id: emotionId });

    return res.status(200).json({ success: true, message: "Emotion History deleted successfully" });
  } catch (error) {
    console.error("Error deleting emotion:", error);
    return res.status(500).json({ success: false, message: "Internal Server Error" });
  }
});

module.exports = emotionRouter;