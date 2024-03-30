// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getAuth } from "firebase/auth";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAmDuGDI9eC1lwFGcxH6nCVSdWReSAMFsg",
  authDomain: "vision4science-terminal.firebaseapp.com",
  projectId: "vision4science-terminal",
  storageBucket: "vision4science-terminal.appspot.com",
  messagingSenderId: "507105212804",
  appId: "1:507105212804:web:a9cc55ebde87be902645d1",
  measurementId: "G-Q4Q5Y46R72"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

export const db = getFirestore(app);
export const auth = getAuth(app);
