/* eslint-disable react/no-unescaped-entities */
"use client";

import React, { useEffect, useRef, useState } from "react";
import {
  Box,
  Button,
  Flex,
  Text,
  VStack,
  Icon,
  Tab,
  TabList,
  TabPanel,
  TabPanels,
  Tabs,
  Image,
  Fade,
} from "@chakra-ui/react";
import { ChevronDownIcon } from "@chakra-ui/icons";
import Navbar from "@/components/navbar";
import ImageCarousel from "@/components/image-carousel";
import Link from "next/link";
import MotionPageTransition from "@/components/motion-page-transition";
import { AnimatePresence } from "framer-motion";
import { onAuthStateChanged } from "firebase/auth";
import { auth } from './firebase';

const HomePage = () => {
  const contentRef = useRef<HTMLDivElement>(null);

  const [offsetY, setOffsetY] = useState(0); // State to track the scroll position
  const handleScroll = () => setOffsetY(window.pageYOffset);

  const scrollToContent = () => {
    contentRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  const [tabIndex, setTabIndex] = useState(0);
  const [fadeKey, setFadeKey] = useState(0);

  const handleTabsChange = (index: number) => {
    setTabIndex(index);
    setFadeKey(index);
  };

  useEffect(() => {
    window.addEventListener("scroll", handleScroll);

    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  useEffect(()=>{
    onAuthStateChanged(auth, (user) => {
        if (user) {
          // User is signed in, see docs for a list of available properties
          // https://firebase.google.com/docs/reference/js/firebase.User
          const uid = user.uid;
          // ...
          console.log("uid", uid)
        } else {
          // User is signed out
          // ...
          console.log("user is logged out")
        }
      });
     
}, [])

  return (
    <AnimatePresence>
      <Box>
        <Flex direction="column" height="100vh">
          <MotionPageTransition>
            <Navbar />
          </MotionPageTransition>
          <Box
            as="video"
            autoPlay
            loop
            muted
            playsInline
            //width="100vw"
            //height="100vh"
            position="absolute"
            zIndex="-1"
            top="0"
            left="0"
            style={{ transform: `translateY(${offsetY * 0.6}px)` }}
          >
            <source src="/background.mp4" type="video/mp4" />
            Your browser does not support the video tag.
          </Box>
          <Box
            position="absolute"
            top="0"
            left="0"
            width="100vw"
            height="100vh"
            zIndex="-1"
            bgColor="brand.100"
            opacity="0.5"
          ></Box>
          <VStack justify="center" align="center" height="full">
            <MotionPageTransition>
              <Text fontSize="6xl" color="white" textAlign="center">
                Vision4Science
              </Text>
            </MotionPageTransition>
            <MotionPageTransition>
              <Button onClick={scrollToContent} variant="ghost" size="lg" p={0}>
                <Icon as={ChevronDownIcon} w={8} h={8} color="white" />
              </Button>
            </MotionPageTransition>
          </VStack>
        </Flex>

        {/* <Box ref={contentRef} width="full" p={8} bg="white">
        <Tabs
          isFitted
          variant="soft-rounded"
          p="4"
          boxShadow="lg"
          rounded="md"
          borderColor="gray.200"
          borderWidth="1px"
          index={tabIndex}
          onChange={handleTabsChange}
        >
          <TabList mb="1em">
            <Tab>Abstract Generation</Tab>
            <Tab>Experiment Generation</Tab>
          </TabList>
          <TabPanels>
            <TabPanel>
              <Fade
                in={true}
                key={fadeKey}
                transition={{ exit: { delay: 1 }, enter: { duration: 0.5 } }}
              >
                <Flex
                  justifyContent="center"
                  direction={{ base: "column", md: "row" }}
                  gap={"10vw"}
                >
                  <Flex direction="column" width="40vw" justifyContent="center">
                    <Text fontSize="2xl" fontWeight="bold" mb={4}>
                      Abstract Generation
                    </Text>
                    <Text mb={4}>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                      sed do eiusmod tempor incididunt ut labore et dolore magna
                      aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                      ullamco laboris nisi ut aliquip ex ea commodo consequat.
                      Duis aute irure dolor in reprehenderit in voluptate velit
                      esse cillum dolore eu fugiat nulla pariatur. Excepteur
                      sint occaecat cupidatat non proident, sunt in culpa qui
                      officia deserunt mollit anim id est laborum.
                    </Text>
                    <Link href="/abstract-generation">
                      <Button bg="brand.100" color="white" width={"10vw"}>
                        Try it!
                      </Button>
                    </Link>
                  </Flex>
                  <Box width={"30vw"}>
                    <ImageCarousel
                      images={[
                        { src: "logo.png", alt: "Example 1" },
                        { src: "logo.png", alt: "Example 2" },
                      ]}
                    />
                  </Box>
                </Flex>
              </Fade>
            </TabPanel>
            <TabPanel>
              <Fade
                in={true}
                key={fadeKey}
                transition={{ exit: { delay: 1 }, enter: { duration: 0.5 } }}
              >
                <Flex
                  justifyContent="center"
                  direction={{ base: "column", md: "row" }}
                  gap={"10vw"}
                >
                  <Flex direction="column" width="40vw" justifyContent="center">
                    <Text fontSize="2xl" fontWeight="bold" mb={4}>
                      Experiment Generation
                    </Text>
                    <Text mb={4}>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                      sed do eiusmod tempor incididunt ut labore et dolore magna
                      aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                      ullamco laboris nisi ut aliquip ex ea commodo consequat.
                      Duis aute irure dolor in reprehenderit in voluptate velit
                      esse cillum dolore eu fugiat nulla pariatur. Excepteur
                      sint occaecat cupidatat non proident, sunt in culpa qui
                      officia deserunt mollit anim id est laborum.
                    </Text>
                    <Link href="/experiment-generation">
                      <Button bg="brand.100" color="white" width={"10vw"}>
                        Try it!
                      </Button>
                    </Link>
                  </Flex>
                  <Box width={"30vw"}>
                    <ImageCarousel
                      images={[
                        { src: "logo.png", alt: "Example 1" },
                        { src: "logo.png", alt: "Example 2" },
                      ]}
                    />
                  </Box>
                </Flex>
              </Fade>
            </TabPanel>
          </TabPanels>
        </Tabs>
      </Box> */}
        <Box ref={contentRef} bg="#03a1fc" padding={10}>
          <Flex p={5} align={"center"} justify={"center"} direction={"column"}>
            <Text
              textAlign={"center"}
              color={"black"}
              fontSize={"3xl"}
              fontWeight={"bold"}
              marginBottom={5}
            >
              Mission
            </Text>
            <Text textAlign={"center"} color={"black"} marginX={40}>
              Vision4Science streamlines lab training and knowledge transfer by
              transforming experiment protocols into interactive, XR visual
              guides. Utilizing OpenAI's API and Apple's Vision Pro, we make
              complex procedures accessible and engaging, enabling scientists
              and interns to quickly master and share laboratory skills. Our
              mission: to revolutionize scientific education and collaboration,
              making experimental learning intuitive and efficient.
            </Text>
          </Flex>
        </Box>
        <Box bg="white">
          <Flex p={5} align={"center"} justify={"center"}>
            <Text textAlign={"center"} color={"rgba(0, 0, 0, 0.4)"}>
              Made @ HackPrinceton 2024
            </Text>
          </Flex>
        </Box>
      </Box>
    </AnimatePresence>
  );
};

export default HomePage;
