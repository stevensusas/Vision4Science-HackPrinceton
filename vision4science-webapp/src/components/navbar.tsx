"use client";

import { Box, Flex, Text, Link, Image, Button, useToast } from "@chakra-ui/react";
import "../style/animated-link.css";
// import { useUser } from "@auth0/nextjs-auth0/client";
import { useEffect, useState } from "react";
import { onAuthStateChanged, signOut } from "firebase/auth";
import { auth } from '../app/firebase';
import { redirect } from "next/navigation";
import { useRouter } from 'next/navigation'


const returnLink = `/api/auth/login?returnTo=${encodeURIComponent("/experiment-generation")}`;

const Navbar = () => {

  // const { authUser, loading, signOut } = useAuth();
  // const { user, error, isLoading } = useUser();

  // if (isLoading) return <div>Loading...</div>;
  // if (error) return <div>{error.message}</div>;

  const [loggedIn, setLoggedIn] = useState(false);
  const router = useRouter();
  const toast = useToast();



  useEffect(()=>{
    onAuthStateChanged(auth, (user) => {
        if (user) {
          // User is signed in, see docs for a list of available properties
          // https://firebase.google.com/docs/reference/js/firebase.User
          const uid = user.uid;
          // ...
          // toast({
          //   title: "Logout successful!",
          //   status: "success",
          //   duration: 9000,
          //   isClosable: true,
          // });
          setLoggedIn(true);
        } else {
          // User is signed out
          // ...
          setLoggedIn(false);
          console.log("user is logged out")
          // toast({
          //   title: "Error logging out...",
          //   status: "error",
          //   duration: 9000,
          //   isClosable: true,
          // });
        }
      });
     
}, [])

const handleLogout = async () => {
  try {
    await signOut(auth);
    // setLoggedIn(false);
    router.push('/');
  } catch (error) {
    // console.error('Error signing out: ', error);

    
  }
};

  return (
    <Flex
      justify="space-between"
      align="center"
      p={6}
      bg="transparent"
      position="fixed"
      width="full"
      zIndex="banner"
      color="white"
    >
      <Link
        href="/"
        _hover={{
          color: "gray",
          textDecoration: "none",
        }}
        mx={2}
      >
        Vision4Science
      </Link>

      <Box>
        {/* <Link
          href="/abstract-generation"
          _hover={{
            color: "gray", 
            textDecoration: "none",
          }}
          mx={5}
        >
          Abstract Generation
        </Link>
        <Link
          href="/experiment-generation"
          _hover={{
            color: "gray", 
            textDecoration: "none", 
          }}
          mx={2}
        >
          Experiment Generation
        </Link> */}

        {loggedIn ? (
          <Flex>
            <Link
              href="/experiment-generation"
              _hover={{
                color: "gray",
                textDecoration: "none",
              }}
              mx={2}
            >
              Experiment Generation
            </Link>
            <Link _hover={{
                color: "gray",
                textDecoration: "none",
              }} onClick={handleLogout} mx={2}>
              Logout
            </Link>
            {/* <a href="/api/auth/logout">
              <Text
                _hover={{
                  color: "gray",
                  textDecoration: "none",
                }}
                mx={2}
              >
                Logout
              </Text>
            </a> */}
          </Flex>
        ) : (
          <Link
              href="/login"
              _hover={{
                color: "gray",
                textDecoration: "none",
              }}
              mx={2}
            >
              Login
            </Link>
          // <a href={returnLink}>
          //   <Text
          //     _hover={{
          //       color: "gray",
          //       textDecoration: "none",
          //     }}
          //   >
          //     Login
          //   </Text>
          // </a>
        )}
      </Box>
    </Flex>
  );
};

export default Navbar;
