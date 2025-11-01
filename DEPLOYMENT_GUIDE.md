# 🚀 Deployment Guide for mahek.space

## Step 1: Push to GitHub (if not already done)

1. Create a new repository on GitHub
2. Push your code:
```powershell
git init
git add .
git commit -m "Initial commit - Riceee journal app"
git remote add origin YOUR_GITHUB_REPO_URL
git push -u origin main
```

## Step 2: Deploy to Vercel

### Option A: Using Vercel Dashboard (Easiest)
1. Go to https://vercel.com
2. Sign up/Login (use GitHub account)
3. Click "Add New" → "Project"
4. Import your GitHub repository
5. Vercel will auto-detect Next.js settings
6. **IMPORTANT:** Add Environment Variables:
   - `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`
   - `CLERK_SECRET_KEY`
   - `DATABASE_URL`
   - `ARCJET_KEY`
   - `PIXABAY_API_KEY` (if you have it)
7. Click "Deploy"

### Option B: Using Vercel CLI
```powershell
npm install -g vercel
vercel login
vercel
```
Follow prompts and add environment variables when asked.

## Step 3: Connect Your Domain (mahek.space)

### In Vercel Dashboard:
1. Go to your deployed project
2. Click "Settings" → "Domains"
3. Add "mahek.space"
4. Vercel will show you DNS records to add

### Update Your Domain DNS (at your domain registrar):
Add these records (Vercel will give you exact values):

**A Record:**
```
Type: A
Name: @
Value: 76.76.21.21 (Vercel's IP)
```

**CNAME Record (for www):**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

## Step 4: Update Clerk URLs

After deployment, update Clerk dashboard:
1. Go to https://dashboard.clerk.com
2. Update URLs to:
   - `https://mahek.space`
   - Sign-in URL: `https://mahek.space/sign-in`
   - Sign-up URL: `https://mahek.space/sign-up`
   - After sign-in: `https://mahek.space/dashboard`

## Step 5: Test!

Visit https://mahek.space and test:
- Homepage loads
- Sign in works
- Create journal entry
- Everything saves to database

---

## 🎯 Quick Checklist:
- [ ] Code pushed to GitHub
- [ ] Project imported to Vercel
- [ ] All environment variables added in Vercel
- [ ] Deployment successful
- [ ] Domain added in Vercel settings
- [ ] DNS records updated at domain registrar
- [ ] Clerk URLs updated
- [ ] Tested live site

---

## 💡 Tips:
- DNS changes can take 24-48 hours to propagate
- Use `https://mahek.space` (with https)
- Vercel provides SSL certificate automatically
- You can use `vercel --prod` to deploy to production

---

Need help with any step? Let me know! 💗
