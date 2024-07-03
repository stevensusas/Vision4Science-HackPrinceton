# Vision4Science

https://github.com/stevensusas/Vision4Science-HackPrinceton/assets/113653645/fe62cadb-b526-4e96-8d77-b7a71fd40eaa


## Inspiration

**Science experiments are hard to learn.** As undergraduate biomedical student researchers ourselves, we talked to many science lab class students and instructors, as well as researchers studying science in an experimental setting, and many of them complained to us about the current way experimental science is communicated in a class and research setting. In the classroom and in research journals, experimental methods and procedures are communicated mainly through text, which poorly captures the intricate details and hands-on nature in complex science experiment procedures. To tackle this pain point in science education and research, we set out to build Vision4Science--**a gen-AI powered Vision Pro App that transforms your text experiment procedure description into a full-fledged hands-on learning experience in the VR/AR space.**

## What it does

To use Vision4Science, simply register for an account and upload your text description of the experimental procedure on to our webapp. Then, log in to your account on your Apple Vision Pro, and select the experimental procedure you just uploaded and want to learn. Vision4Science will have utilized the text input and its generative AI engine to render an interactive space, providing all the materials, equipments you need, as well as a detailed step-by-step instruction on how to carry out the experiment with the objects around you. Happy learning!

## How we built it

![Vision4Science Architecture (1)](https://github.com/stevensusas/Vision4Science-HackPrinceton/assets/113653645/95735086-9898-4b4b-aeb2-9a9541d0f92f)

We build the webapp with Next.js and React native. We used OpenAI API for the generative AI functionalities and Firebase for our database. To build the app on the Apple Vision Pro, we used Swift and Reality Composer Pro.

## Challenges we ran into

The hardest part of the entire project is definitely the Vision Pro app. Our team went into building without previous programming experience in Swift and XR development, so the learning curve was steep at the beginning. Since Vision Pro is also a relatively new product, there are also limited tutorials and resources that we could find online on development in the VisionOS, and we had to rely a lot on the official documentations from Apple. Some of these documentation were hard to figure out. 

## Accomplishments that we're proud of

As we were all new to Swift and the Vision Pro App, we are proud to have grasped the syntax and essential logic for Vision Pro app development. We're particularly proud of developing two applications—a web app and a Vision Pro app—within less than 36 hours during a hackathon. We are also proud to have integrated generative AI into our app, witnessing its potential in this new context.

## What's next for Vision4Science

1. Polish our Vision Pro app, particularly by adding more 3D object assets and refining their interactivity logic.
2. Integrate retrieval-augmented generation in our gen-AI engine to enhance the accuracy and reliability of our generative AI functionalities.
