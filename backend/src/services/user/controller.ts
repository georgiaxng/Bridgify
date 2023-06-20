import { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken'
import cors from 'cors'
import 'dotenv/config'

const bcrypt = require("bcryptjs")
const mongoose = require("mongoose")


const UserSchema = new mongoose.Schema({
  username: String,
  password: String
})

const UserModel = mongoose.model("User", UserSchema, "User")

export const test = async (req: any, res: Response, next: NextFunction) => {
  // 1. get user from the frontend
  const newUser = { email: req.body.email, password: req.body.password }
  // 2. check if the email is existed
  const user = await UserModel.findOne({ email: req.body.email })
  if (user != null) {
    return res.status(200).json({ Message: `Email: ${req.body.email} was already register` })
  }

  // 3. hash password
  const hashedPassword = await bcrypt.hash(newUser.password, 10)

  // 4. add a new user to mongodb
  UserModel.collection.insertOne({ email: req.body.email, password: hashedPassword })

  // 5. send status back to requestor
  return res.status(200).json({ Message: `Password : ${hashedPassword}` })
};


export const signup = async (req: any, res: Response, next: NextFunction) => {
  // 1. get user from the frontend
  const newUser = { email: req.body.email, password: req.body.password }
  // 2. check if the email is existed
  const user = await UserModel.findOne({ email: req.body.email })
  if (user != null) {
    return res.status(200).json({ Message: `Email: ${req.body.email} was already register` })
  }

  // 3. hash password
  const hashedPassword = await bcrypt.hash(newUser.password, 10)

  // 4. add a new user to mongodb
  UserModel.collection.insertOne({ email: req.body.email, password: hashedPassword })

  // 5. send status back to requestor
  return res.status(200).json({Message : `Password : ${hashedPassword}`})
};

export const login = async (req: any, res: Response, next: NextFunction) => {
  // 1. find the user
  const user = await UserModel.findOne({ email: req.body.email })

  // 2. compare the password from req vs password in db - Authenticated ok
  const userAllowed = await bcrypt.compare(req.body.password, user.password)

  // 3. create jwt token = Authorization
  if (userAllowed) {

    const accessToken = jwt.sign(user.toJSON(),'secret-key-shhhh',{expiresIn:604800})
   
    // 4. send JWT token to frontend requestor
    res.status(200).send({ accessToken: accessToken })
  } else {
    res.send({ Message : 'No user found or invalid password' })
  }
};