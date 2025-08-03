# GitHub Token Setup Script for CycleCoach
# Run this script to configure GitHub authentication

Write-Host "🔐 GitHub Token Setup for CycleCoach" -ForegroundColor Green
Write-Host ""

# Check if Git is available
try {
    $gitVersion = git --version
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git not found. Please install Git first." -ForegroundColor Red
    exit 1
}

# Configure Git credential helper
Write-Host "🔧 Configuring Git credential helper..." -ForegroundColor Yellow
git config --global credential.helper manager-core

Write-Host ""
Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Go to GitHub.com → Settings → Developer settings → Personal access tokens"
Write-Host "2. Generate a new token with 'repo' and 'workflow' permissions"
Write-Host "3. Copy the token"
Write-Host "4. The next time you push, use your token as the password"
Write-Host ""
Write-Host "💡 Pro tip: You can also use GitHub CLI for easier authentication:"
Write-Host "   winget install GitHub.cli"
Write-Host "   gh auth login"
Write-Host ""

# Test current authentication
Write-Host "🧪 Testing current authentication..." -ForegroundColor Yellow
try {
    git ls-remote origin > $null 2>&1
    Write-Host "✅ Authentication working!" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Authentication may need setup. Follow the steps above." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎯 Your repository: https://github.com/cxornado/cyclecoach" -ForegroundColor Cyan 