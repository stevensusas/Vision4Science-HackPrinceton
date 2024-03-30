// app/layout.tsx
import { Providers } from "./providers";
import { UserProvider } from "@auth0/nextjs-auth0/client";
// import { AuthUserProvider } from "./AuthUserContext";

import "@fontsource/poppins/400.css";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <Providers>
          {/* <UserProvider>{children} </UserProvider> */}
          {/* <AuthUserProvider>{children}</AuthUserProvider> */}
          {children}
        </Providers>
      </body>
    </html>
  );
}
