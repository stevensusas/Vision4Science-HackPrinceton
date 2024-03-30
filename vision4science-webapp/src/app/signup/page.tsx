"use client";

import React, { useEffect, useRef, useState } from "react";

import { collection, addDoc } from "firebase/firestore";
import { auth, db } from "../firebase";
import axios from "axios";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { useRouter } from 'next/navigation'



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

export default function SignupPage() {

  const toast = useToast();

  const [emailInput, setEmailInput] = useState("");
  const [passwordInput, setPasswordInput] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = () => {
    setSubmitted(true);
  };

  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();


  // const { createUserWithEmailAndPassword } = useAuth();

  const handleGenerateClick = async () => {
    setIsLoading(true);

    //check if passwords match. If they do, create user in Firebase
    // and redirect to your logged in page.
      await createUserWithEmailAndPassword(auth, emailInput, passwordInput)
      .then(authUser => {
        // console.log("Success. The user is created in Firebase")
        toast({
          title: "Sign up successful!",
          status: "success",
          duration: 4000,
          isClosable: true,
        });
        router.push("/experiment-generation");
      })
      .catch(error => {
        // An error occurred. Set error message to be displayed to user
        // console.log(error.message)
        toast({
          title: "Error: " + error.message,
          status: "error",
          duration: 9000,
          isClosable: true,
        });
      });

    setIsLoading(false);

    // toast({
    //   title: "Login Successful!",
    //   status: "success",
    //   duration: 9000,
    //   isClosable: true,
    // });
  };

  const handleEmailInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setEmailInput(event.target.value);
  };

  const handlePasswordInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setPasswordInput(event.target.value);
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
            width="30vw"
            borderRadius={"20px"}
            // px="5"
            // pt="5"
            padding={10}
          >
            <Text
              lineHeight="55px"
              fontSize="5xl"
              fontWeight="semi-bold"
              align={"center"}
              color="white"
            >
                Sign Up
            </Text>
            <Input
              bg={"white"}
              placeholder="Email"
              value={emailInput}
              onChange={handleEmailInputChange}
              type="email"
            />
            <Input
              bg={"white"}
              placeholder="Password"
              value={passwordInput}
              onChange={handlePasswordInputChange}
              type="password"
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
              loadingText="Signing up..."
              disabled={isLoading}
            >
              Sign Up
            </Button>
            <Link
              href="/login"
              _hover={{
                color: "gray",
                textDecoration: "none",
              }}
              mx={2}
              alignSelf={"center"}
              color={"white"}
            >
              Have an account already? Login
            </Link>
          </VStack>
        </Flex>
      </Box>
    </Box>
  );
}
