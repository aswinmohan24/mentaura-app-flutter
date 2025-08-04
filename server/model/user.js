const mongoose = require("mongoose");

const normalizeEmptyToNull = (val) => {
  return val === '' ? null : val;
};

const userSchema = mongoose.Schema({
    name:{
        type: String,
        required : true
    },
    age:{
        type: String,
        required : true
    },
    gender : {
        type: String,
        required : true
    },
    phoneNumber:{
        type: String,
        unique:true,
        sparse: true,
        set: (val) => {
    return val === '' || val === null || val === undefined ? undefined : val;
  },

        
    },
    email:{
        type:String,
         unique:true,
        sparse : true,
        set: (val) => {
    return val === '' || val === null || val === undefined ? undefined : val;
  },

        
    },
    firebaseUid : {
        type : String,
        required : true,
        unique : true
    }
});

const User = mongoose.model("User", userSchema);
module.exports = User;