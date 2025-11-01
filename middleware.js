import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server";
import arcjet, { createMiddleware, detectBot, shield } from "@arcjet/next";
import { NextResponse } from "next/server";

// Protected routes that require authentication
const isProtectedRoute = createRouteMatcher([
  "/dashboard(.*)",
  "/journal(.*)",
  "/collection(.*)",
]);

// Create Arcjet middleware (safe for development)
let aj = null;
try {
  // Use DRY_RUN in non-production so missing/invalid keys don't block requests
  const runMode = process.env.NODE_ENV === "production" ? "LIVE" : "DRY_RUN";

  if (process.env.ARCJET_KEY) {
    aj = arcjet({
      key: process.env.ARCJET_KEY,
      // characteristics: ["userId"], // Track based on Clerk userId
      rules: [
        // Shield protection for content and security
        shield({
          mode: runMode,
        }),
        detectBot({
          mode: runMode, // will block requests only in production
          allow: [
            "CATEGORY:SEARCH_ENGINE", // Google, Bing, etc
            // See the full list at https://arcjet.com/bot-list
          ],
        }),
      ],
    });
  } else {
    // No ARCJET_KEY present — run in DRY_RUN by not initializing remote enforcement
    aj = null;
  }
} catch (e) {
  // If Arcjet initialization fails (invalid key, network), fall back to noop
  // Log the error for debugging but don't block requests in development
  // eslint-disable-next-line no-console
  console.warn("ArcJet initialization failed, continuing without ArcJet:", e?.message || e);
  aj = null;
}

// Create base Clerk middleware
const clerk = clerkMiddleware(async (auth, req) => {
  const { userId } = await auth();

  if (!userId && isProtectedRoute(req)) {
    const { redirectToSignIn } = await auth();
    return redirectToSignIn();
  }

  return NextResponse.next();
});

// Chain middlewares - ArcJet runs first (if available), then Clerk
const exportedMiddleware = aj ? createMiddleware(aj, clerk) : clerk;

export default exportedMiddleware;

// Keep your existing matcher config for consistency
export const config = {
  matcher: [
    // Skip Next.js internals and all static files
    "/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)",
    // Always run for API routes
    "/(api|trpc)(.*)",
  ],
};
