const express = require("express");
const verifyFirebaseToken = require("../middleware/auth.middleware");
const User = require("../model/user");

const authRouter = express.Router();

// create user -----
authRouter.post("/api/v1/createuser",verifyFirebaseToken, async (req, res) => {
  try {
    const { name, phoneNumber, email, age, gender} = req.body;
    const firebaseUid = req.firebaseUid;
    const existingUser = await User.findOne({firebaseUid});

    if (!existingUser) {
      const newUser = new User({
        name,
        email,
        firebaseUid,
        phoneNumber,
        age,
        gender,
      });

      const savedUser = await newUser.save();
      return res.status(201).json({ success: true, user: savedUser });
    }

    return res.status(409).json({
      success: false,
      message:"User already exists"
    });

  } catch (error) {
    console.log(`Error creating user: ${error}`);
     if (error.code === 11000 && error.keyValue && error.keyValue.phoneNumber) {
    
    return res.status(409).json({success : false, message: 'User with this phone number already exists' });
  }
   if (error.code === 11000 && error.keyValue && error.keyValue.email) {
    
    return res.status(409).json({success : false, message: 'User with this mail id already exists' });
  }
    return res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
});

authRouter.get("/api/v1/getuser", verifyFirebaseToken, async (req, res)=>{

 try {
   const firebaseUid = req.firebaseUid;
  const user = await User.findOne({firebaseUid});
  if(!user){
    return res.status(404).json({success : false , message : "user not found"});
  }
  return res.status(200).json({success : true, user});
  
 } catch (error) {
  console.log(`Unable to get user data ${error}`);
  return res.status(500).json({success : false, message : "Internal server error"});
 }
});


authRouter.delete("/api/v1/deleteuser", verifyFirebaseToken, async (req, res) =>{
  
  try {
    const firebaseUid = req.firebaseUid;
    const deleteuser = await User.findOneAndDelete({firebaseUid});
    if (!deleteuser) {
      return res.status(404).json({success : false, message :  "User not found"});
    }
    return res.status(200).json({success : true, message : "User deleted successfully"});
    
  } catch (error) {
     res.status(500).json({ message: 'Error deleting user', error });
    
  }
} );

module.exports = authRouter;
