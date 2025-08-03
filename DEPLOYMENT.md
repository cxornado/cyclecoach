# 🚀 CycleCoach Deployment Guide

This guide will help you set up automatic deployments from GitHub to Netlify with a safe testing environment.

## 📋 Prerequisites

- ✅ GitHub account
- ✅ Netlify account  
- ✅ Domain: `cyclecoach.site` (already owned)

## 🔧 Step 1: Initialize Git Repository

```bash
# In your project directory
git init
git add .
git commit -m "Initial CycleCoach landing page"
```

## 🔗 Step 2: Create GitHub Repository

1. Go to [GitHub.com](https://github.com)
2. Click "New repository"
3. Name it: `cyclecoach-landing`
4. Make it **Public** (required for free Netlify)
5. Don't initialize with README (we already have one)
6. Click "Create repository"

## 📤 Step 3: Push to GitHub

```bash
# Replace YOUR_USERNAME with your actual GitHub username
git remote add origin https://github.com/YOUR_USERNAME/cyclecoach-landing.git
git branch -M main
git push -u origin main
```

## 🌐 Step 4: Set Up Netlify

### Option A: Connect GitHub Repository (Recommended)

1. Go to [Netlify.com](https://netlify.com)
2. Click "New site from Git"
3. Choose "GitHub"
4. Select your `cyclecoach-landing` repository
5. Configure build settings:
   - **Build command**: Leave empty (static site)
   - **Publish directory**: `.` (root directory)
6. Click "Deploy site"

### Option B: Manual Upload (Quick Test)

1. Go to [Netlify.com](https://netlify.com)
2. Drag and drop your `index.html` file
3. Note the generated URL (e.g., `amazing-name-123.netlify.app`)

## 🔐 Step 5: Configure GitHub Secrets

For automated deployments, you need to add Netlify credentials to GitHub:

### Get Netlify Credentials:

1. In Netlify, go to **User Settings** → **Applications** → **Personal access tokens**
2. Click "New access token"
3. Name it: `GitHub Actions`
4. Copy the token

### Get Site ID:

1. In Netlify, go to your site dashboard
2. Go to **Site settings** → **General**
3. Copy the **Site ID**

### Add to GitHub Secrets:

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click "New repository secret"
4. Add these secrets:
   - `NETLIFY_AUTH_TOKEN`: Your access token
   - `NETLIFY_SITE_ID`: Your site ID

## 🌍 Step 6: Configure Custom Domain

1. In Netlify, go to **Domain settings**
2. Click "Add custom domain"
3. Enter: `cyclecoach.site`
4. Follow DNS configuration instructions

### DNS Configuration:

Add these records to your domain registrar:

```
Type: A
Name: @
Value: 75.2.60.5

Type: CNAME  
Name: www
Value: your-site-name.netlify.app
```

## 🧪 Step 7: Test Your Workflow

### Test Preview Deployments:

1. Create a new branch:
```bash
git checkout -b test-changes
```

2. Make a small change to `index.html`

3. Push and create PR:
```bash
git add .
git commit -m "Test preview deployment"
git push origin test-changes
```

4. Go to GitHub and create a Pull Request
5. Check that Netlify creates a preview URL

### Test Production Deployment:

1. Merge your PR to main
2. Check that Netlify deploys to production
3. Visit `cyclecoach.site` to verify

## 🔄 Step 8: Development Workflow

### For Safe Testing:

1. **Create feature branch:**
```bash
git checkout -b feature/new-section
```

2. **Make changes and test locally:**
```bash
npm run dev
# Visit http://localhost:3000
```

3. **Push and create PR:**
```bash
git add .
git commit -m "Add new feature"
git push origin feature/new-section
```

4. **Review preview deployment** (Netlify will comment on your PR)

5. **Merge to main** for production deployment

## 🛠️ Troubleshooting

### Common Issues:

**Build fails:**
- Check that `index.html` is in the root directory
- Verify all files are committed to Git

**Domain not working:**
- Wait 24-48 hours for DNS propagation
- Check DNS records are correct

**GitHub Actions not running:**
- Verify secrets are set correctly
- Check repository permissions

### Useful Commands:

```bash
# Check local site
npm run dev

# Check Git status
git status

# View deployment logs
# Go to Netlify dashboard → Deploys → Click on deployment
```

## 📊 Monitoring

- **Netlify Dashboard**: View deployments, analytics, form submissions
- **GitHub Actions**: Monitor build status and logs
- **Domain Analytics**: Track traffic and performance

## 🎯 Next Steps

1. ✅ Set up email form integration (Mailchimp, Formspree)
2. ✅ Add Google Analytics
3. ✅ Configure SEO meta tags
4. ✅ Set up A/B testing
5. ✅ Add performance monitoring

---

**Your site will be live at:** https://cyclecoach.site

**Preview deployments will be available for every PR!** 