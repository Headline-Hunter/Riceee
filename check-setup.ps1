# Environment Setup Checker

Write-Host ""
Write-Host "========================================"
Write-Host "   Journal App - Setup Checker"
Write-Host "========================================"
Write-Host ""

# Check if .env.local exists
Write-Host "Checking .env.local file..." -NoNewline
if (Test-Path ".env.local") {
    Write-Host " Found" -ForegroundColor Green
    
    $envContent = Get-Content ".env.local" -Raw
    
    # Check each required variable
    Write-Host ""
    Write-Host "Checking environment variables:" -ForegroundColor Yellow
    
    $vars = @(
        "NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY",
        "CLERK_SECRET_KEY",
        "DATABASE_URL",
        "PIXABAY_API_KEY",
        "ARCJET_KEY"
    )
    
    $missingVars = @()
    
    foreach ($var in $vars) {
        Write-Host "  - $var..." -NoNewline
        if ($envContent -match "$var=.+") {
            if ($envContent -match "$var=your_" -or $envContent -match "$var=\s*$") {
                Write-Host " Not configured" -ForegroundColor Yellow
                $missingVars += $var
            } else {
                Write-Host " OK" -ForegroundColor Green
            }
        } else {
            Write-Host " Missing" -ForegroundColor Red
            $missingVars += $var
        }
    }
    
    if ($missingVars.Count -gt 0) {
        Write-Host ""
        Write-Host "Warning: The following variables need configuration:" -ForegroundColor Yellow
        foreach ($var in $missingVars) {
            Write-Host "  - $var" -ForegroundColor Yellow
        }
    } else {
        Write-Host ""
        Write-Host "All environment variables are configured!" -ForegroundColor Green
    }
} else {
    Write-Host " Not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "Error: .env.local file not found!" -ForegroundColor Red
    Write-Host "A template has been created for you." -ForegroundColor Yellow
}

# Check node_modules
Write-Host ""
Write-Host "Checking dependencies..." -NoNewline
if (Test-Path "node_modules") {
    Write-Host " Installed" -ForegroundColor Green
} else {
    Write-Host " Not installed" -ForegroundColor Red
    Write-Host "Run: npm install" -ForegroundColor Yellow
}

# Check Prisma Client
Write-Host "Checking Prisma Client..." -NoNewline
if (Test-Path "node_modules\.prisma\client") {
    Write-Host " Generated" -ForegroundColor Green
} else {
    Write-Host " Not generated" -ForegroundColor Red
    Write-Host "Run: npx prisma generate" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "========================================"
Write-Host "   Next Steps"
Write-Host "========================================"
Write-Host ""
Write-Host "1. Fill in all values in .env.local file"
Write-Host "2. Run: npx prisma generate"
Write-Host "3. Run: npx prisma migrate deploy"
Write-Host "4. Run: npm run dev"
Write-Host ""
Write-Host "See SETUP_GUIDE.md for detailed instructions"
Write-Host ""
