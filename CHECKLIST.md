# ✅ Setup Checklist

Copy this checklist and mark items as you complete them!

## 📦 Dependencies & Installation
- [x] Node.js installed
- [x] npm packages installed (`npm install`)
- [ ] Prisma Client generated (`npx prisma generate`)

## 🔐 Clerk Authentication Setup
- [ ] Created Clerk account at https://clerk.com
- [ ] Created new application in Clerk dashboard
- [ ] Copied Publishable Key to `.env.local`
- [ ] Copied Secret Key to `.env.local`
- [ ] Tested sign-in page loads at `/sign-in`

**Clerk Dashboard:** https://dashboard.clerk.com

## 🗄️ NeonDB Database Setup
- [ ] Created NeonDB account at https://neon.tech
- [ ] Created new project in NeonDB
- [ ] Copied connection string to `.env.local` as `DATABASE_URL`
- [ ] Ran `npx prisma generate`
- [ ] Ran `npx prisma migrate deploy` or `npx prisma db push`
- [ ] Verified database has tables (use `npx prisma studio`)

**NeonDB Dashboard:** https://console.neon.tech

## 🖼️ Pixabay API Setup
- [ ] Created Pixabay account at https://pixabay.com
- [ ] Got API key from https://pixabay.com/service/about/api/
- [ ] Added API key to `.env.local` as `PIXABAY_API_KEY`
- [ ] Tested mood images appear in journal entries

**Get API Key:** https://pixabay.com/api/docs/

## 🛡️ ArcJet Security Setup
- [ ] Created ArcJet account at https://arcjet.com
- [ ] Created new site/project
- [ ] Copied site key to `.env.local` as `ARCJET_KEY`
- [ ] Verified no blocking errors in console

**ArcJet Dashboard:** https://app.arcjet.com

## 🚀 Running the Application
- [ ] All environment variables set in `.env.local`
- [ ] Ran `npm run dev` successfully
- [ ] Application loads at http://localhost:3000
- [ ] No errors in terminal or browser console

## ✅ Testing Features
- [ ] Can access homepage
- [ ] Sign-up works
- [ ] Sign-in works
- [ ] Dashboard loads after login
- [ ] Can create a collection
- [ ] Can write a journal entry
- [ ] Mood selection works
- [ ] Mood images load correctly
- [ ] Can view entries
- [ ] Can edit entries
- [ ] Can delete entries
- [ ] Can delete collections
- [ ] Analytics page shows data

## 🐛 Troubleshooting
If you encounter issues:

1. **Run the setup checker:**
   ```powershell
   .\check-setup.ps1
   ```

2. **Check console errors** in browser DevTools (F12)

3. **Check terminal** for server errors

4. **Verify .env.local** has no typos

5. **Restart dev server** after changing .env.local:
   - Stop server (Ctrl+C)
   - Run `npm run dev` again

6. **Clear Prisma cache** if database issues:
   ```powershell
   npx prisma generate
   rm -r node_modules/.prisma
   npm install
   ```

## 📝 Notes Section
Use this space to jot down your API keys temporarily (DELETE after adding to .env.local):

```
Clerk Publishable Key: 
Clerk Secret Key: 
Database URL: 
Pixabay API Key: 
ArcJet Key: 
```

---

## 🎉 You're Done When:
- [ ] All checkboxes above are marked
- [ ] Application runs without errors
- [ ] You can create and view journal entries
- [ ] All features work as expected

**Ready to use!** 🚀
