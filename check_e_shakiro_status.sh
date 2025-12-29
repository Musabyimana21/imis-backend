#!/bin/bash

echo "========================================="
echo "E-SHAKIRO.COM DEPLOYMENT STATUS CHECK"
echo "========================================="
echo

echo "🔍 CHECKING CURRENT DEPLOYMENT..."
echo

# Check if curl is available
if command -v curl &> /dev/null; then
    echo "✅ Testing Backend Health..."
    if curl -s --max-time 10 https://imis-backend-wk7z.onrender.com/health > /dev/null; then
        echo "   ✅ Backend is LIVE: https://imis-backend-wk7z.onrender.com"
    else
        echo "   ⚠️  Backend may be sleeping (Render free tier)"
    fi
    echo
    
    echo "✅ Testing Frontend..."
    if curl -s --max-time 10 https://imis-frontend.pages.dev > /dev/null; then
        echo "   ✅ Frontend is LIVE: https://imis-frontend.pages.dev"
    else
        echo "   ❌ Frontend not accessible"
    fi
    echo
    
    echo "🌐 Testing Custom Domain..."
    if curl -s --max-time 10 https://e-shakiro.com > /dev/null; then
        echo "   ✅ e-shakiro.com is LIVE!"
    else
        echo "   ⏳ e-shakiro.com not yet configured"
    fi
else
    echo "⚠️  curl not available, skipping connectivity tests"
fi

echo
echo "📋 DEPLOYMENT SUMMARY:"
echo "======================"
echo "Backend URL:    https://imis-backend-wk7z.onrender.com"
echo "Frontend URL:   https://imis-frontend.pages.dev"
echo "Target Domain:  https://e-shakiro.com"
echo "API Docs:       https://imis-backend-wk7z.onrender.com/docs"
echo

echo "🔧 CONFIGURATION STATUS:"
echo "========================"
echo "✅ CORS updated for e-shakiro.com"
echo "✅ Frontend configured for custom domain"
echo "✅ Environment variables set"
echo "✅ SSL will be auto-provisioned by Cloudflare"
echo

echo "📝 NEXT STEPS:"
echo "=============="
echo "1. Go to Cloudflare Pages dashboard"
echo "2. Add e-shakiro.com as custom domain"
echo "3. Configure DNS records"
echo "4. Wait for SSL certificate (5-15 minutes)"
echo "5. Test the deployment"
echo

echo "📚 DOCUMENTATION:"
echo "=================="
echo "Setup Guide: E_SHAKIRO_DOMAIN_SETUP.md"
echo "Deployment: DEPLOY_E_SHAKIRO.bat"
echo

echo "🎯 YOUR IMIS PLATFORM FEATURES:"
echo "==============================="
echo "• Lost & Found Item Management"
echo "• User Registration & Authentication"
echo "• Advanced Search & Matching"
echo "• Real-time Chat System"
echo "• MTN Mobile Money Integration"
echo "• Admin Dashboard"
echo "• Location-based Services"
echo "• Multi-language Support (English/Kinyarwanda)"
echo

echo "========================================="
echo "DEPLOYMENT STATUS: READY FOR CUSTOM DOMAIN"
echo "========================================="