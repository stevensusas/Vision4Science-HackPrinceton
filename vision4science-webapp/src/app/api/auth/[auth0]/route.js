import { handleAuth, handleLogin } from "@auth0/nextjs-auth0";

// export const GET = handleAuth({
//   async login(req, res) {
//     await handleLogin(req, res, {
//       returnTo: "/experiment-generation",
//     });
//   },
// });

// export const GET = handleAuth({
//   async login(req, res) {
//     await handleLogin(req, res, {
//       returnTo: "/experiment-generation",
//     });
//   },
// });

export const GET = handleAuth();