/* eslint-disable react/no-unescaped-entities */
"use client";

import React, { useEffect, useRef, useState } from "react";

import { collection, addDoc } from "firebase/firestore";
import { db } from "../firebase";
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
import { signInWithEmailAndPassword } from "firebase/auth";
import {auth} from "../firebase";
import { redirect } from "next/navigation";
import { useRouter } from 'next/navigation'


export default function LoginPage() {

  const toast = useToast();
  const router = useRouter();


  const [emailInput, setEmailInput] = useState("");
  const [passwordInput, setPasswordInput] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = () => {
    setSubmitted(true);
  };

  const [isLoading, setIsLoading] = useState(false);

  const handleGenerateClick = async () => {
    setIsLoading(true);

    await signInWithEmailAndPassword(auth, emailInput, passwordInput)
      .then(authUser => {
        // console.log("Success. The user is logged in")
        toast({
            title: "Login successful!",
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
                Login
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
              loadingText="Logging in..."
              disabled={isLoading}
            >
              Login
            </Button>
            <Link
              href="/signup"
              _hover={{
                color: "gray",
                textDecoration: "none",
              }}
              mx={2}
              alignSelf={"center"}
              color={"white"}
            >
              Don't have an account? Sign Up
            </Link>
          </VStack>
        </Flex>
      </Box>
    </Box>
  );
}
