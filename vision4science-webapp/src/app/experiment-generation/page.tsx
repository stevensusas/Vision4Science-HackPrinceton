"use client";

import React, { useEffect, useRef, useState } from "react";
// import { useUser } from '@auth0/nextjs-auth0/client';

import { collection, addDoc } from "firebase/firestore";
import { auth, db } from "../firebase";
import axios from "axios";

import {
  Box,
  Center,
  Heading,
  VStack,
  Button,
  Image,
  Text,
  Flex,
  Link,
  Spacer,
  FormControl,
  FormLabel,
  Textarea,
  SlideFade,
  IconButton,
  Skeleton,
  useToast,
  Input,
} from "@chakra-ui/react";
import { DownloadIcon } from "@chakra-ui/icons";
import Navbar from "@/components/navbar";
import { onAuthStateChanged } from "firebase/auth";

export default function ExperimentGenerationPage() {
  // const { user, error } = useUser();

  const toast = useToast();

  const [text, setText] = useState("");
  const [titleInput, setTitleInput] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = () => {
    setSubmitted(true);
  };

  const [textAreaInput, setTextAreaInput] = useState("");

  const [isLoading, setIsLoading] = useState(false);

  const [userId, setUserId] = useState("");

  useEffect(()=>{
    onAuthStateChanged(auth, (user) => {
        if (user) {
          // User is signed in, see docs for a list of available properties
          // https://firebase.google.com/docs/reference/js/firebase.User
          const uid = user.uid;
          // ...
          setUserId(uid);
        } else {
          // User is signed out
          // ...
          setUserId("");
          console.log("user is logged out")
        }
      });
     
}, [])

  const handleGenerateClick = async () => {
    setIsLoading(true);

    const res = await fetch("/api/chat", {
      method: "POST",
      headers: {
        "Content-type": "application/json",
      },
      body: JSON.stringify({ protocol: textAreaInput }),
    })
      .then((response) => {
        // console.log("RESPONSE:", response.json());
        return response.json();
      })
      .catch((error) => {
        console.error(error);
      });

    console.log("RES:", res);
    console.log("User: ", userId);

    // await addDoc(collection(db, `users/${user!.sid}/protocols`), {
    await addDoc(collection(db, `users/${userId}/protocols`), {
      reagents_objects: res.data.reagents_objects,
      steps: res.data.steps,
      title: titleInput,
      description: textAreaInput,
    });

    setIsLoading(false);

    toast({
      title: "Generation Successful!",
      description:
        "We've generated your experimental procedures. You can check out the result in the VisionOS terminal!",
      status: "success",
      duration: 9000,
      isClosable: true,
    });
  };

  const handleInputChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
    setTextAreaInput(event.target.value);
  };

  const handleTitleInputChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    setTitleInput(event.target.value);
  };

  return (
    <Box>
      <Navbar />

      <Box height="100vh" px={"3vw"} color="black">
        <Box
          position="absolute"
          top="0"
          left="0"
          width="100vw"
          height="100vh"
          zIndex="-1"
          bgColor="brand.300"
        ></Box>
        <Flex h={"full"} alignItems={"center"} justifyContent={"center"} px="5">
          <VStack
            boxShadow="dark-lg"
            spacing={4}
            align="stretch"
            mt={4}
            width="50vw"
            borderRadius={"20px"}
            // px="5"
            // pt="5"
            padding={10}
          >
            <Text
              lineHeight="55px"
              fontSize="5xl"
              fontWeight="semi-bold"
              align={"left"}
              color="white"
            >
              Experiment Generation
            </Text>
            <Text fontSize="large" align={"left"} color="white">
              Please enter the complete text of your protocol below. Our system
              will analyze the information and generate a step-by-step XR
              visualization for you to explore and interact with.
            </Text>
            <Input
              bg={"white"}
              placeholder="Enter the title of your experiment here..."
              value={titleInput}
              onChange={handleTitleInputChange}
            />
            <Textarea
              placeholder="Enter your experiment protocol here..."
              size="md"
              background={"white"}
              height={"20vh"}
              onChange={handleInputChange}
            />
            <Button
              color="white"
              border={"1px"}
              bg="brand.300"
              _hover={{
                // color: "gray",
                boxShadow: "dark-lg",
              }}
              onClick={handleGenerateClick}
              size="lg"
              isLoading={isLoading}
              loadingText="Generating..."
              disabled={isLoading}
            >
              Generate
            </Button>
          </VStack>
        </Flex>
      </Box>
    </Box>
  );
}
