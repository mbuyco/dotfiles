---
name: web-performance-optimization
description: "Optimize website and web application performance including loading speed, Core Web Vitals, bundle size, caching strategies, and runtime performance"
risk: unknown
source: community
date_added: "2026-02-27"
---

# Web Performance Optimization

## Overview

Help developers optimize website and web application performance to improve user experience, SEO rankings, and conversion rates. This skill provides systematic approaches to measure, analyze, and improve loading speed, runtime performance, and Core Web Vitals metrics.

## When to Use This Skill

- Use when website or app is loading slowly
- Use when optimizing for Core Web Vitals (LCP, INP, CLS)
- Use when reducing JavaScript bundle size
- Use when improving Time to Interactive (TTI)
- Use when optimizing images and assets
- Use when implementing caching strategies
- Use when debugging performance bottlenecks
- Use when preparing for performance audits

## How It Works

### Step 1: Measure Current Performance

I'll help you establish baseline metrics:
- Run Lighthouse audits
- Measure Core Web Vitals (LCP, INP, CLS)
- Check bundle sizes
- Analyze network waterfall
- Identify performance bottlenecks

### Step 2: Identify Issues

Analyze performance problems:
- Large JavaScript bundles
- Unoptimized images
- Render-blocking resources
- Slow server response times
- Missing caching headers
- Layout shifts
- Long tasks blocking main thread

### Step 3: Prioritize Optimizations

Focus on high-impact improvements:
- Critical rendering path optimization
- Code splitting and lazy loading
- Image optimization
- Caching strategies
- Third-party script optimization

### Step 4: Implement Optimizations

Apply performance improvements:
- Optimize assets (images, fonts, CSS, JS)
- Implement code splitting
- Add caching headers
- Lazy load non-critical resources
- Optimize critical rendering path

### Step 5: Verify Improvements

Measure impact of changes:
- Re-run Lighthouse audits
- Compare before/after metrics
- Monitor real user metrics (RUM)
- Test on different devices and networks

## Examples

### Example 1: Optimizing Core Web Vitals

```markdown
## Performance Audit Results

### Current Metrics (Before Optimization)
- **LCP (Largest Contentful Paint):** 4.2s ❌ (should be < 2.5s)
- **INP (Interaction to Next Paint):** 180ms ❌ (target < 200ms)
- **CLS (Cumulative Layout Shift):** 0.25 ❌ (should be < 0.1)
- **Lighthouse Score:** 62/100

### Issues Identified

1. **LCP Issue:** Hero image (2.5MB) loads slowly
2. **INP Issue:** Large JavaScript bundle (850KB) blocks main thread
3. **CLS Issue:** Images without dimensions cause layout shifts

### Optimization Plan

#### Fix LCP (Largest Contentful Paint)

**Problem:** Hero image is 2.5MB and loads slowly

**Solutions:**
\`\`\`html
<!-- Before: Unoptimized image -->
<img src="/hero.jpg" alt="Hero">

<!-- After: Optimized with modern formats -->
<picture>
  <source srcset="/hero.avif" type="image/avif">
  <source srcset="/hero.webp" type="image/webp">
  <img
    src="/hero.jpg"
    alt="Hero"
    width="1200"
    height="600"
    loading="eager"
    fetchpriority="high"
  >
</picture>
\`\`\`

**Additional optimizations:**
- Compress image to < 200KB
- Use CDN for faster delivery
- Preload hero image: `<link rel="preload" as="image" href="/hero.avif">`

#### Fix INP (Interaction to Next Paint)

**Problem:** 850KB JavaScript bundle blocks main thread

**Solutions:**

1. **Code Splitting:**
\`\`\`javascript
// Before: Everything in one bundle
import { HeavyComponent } from './HeavyComponent';
import { Analytics } from './analytics';
import { ChatWidget } from './chat';

// After: Lazy load non-critical code
const HeavyComponent = lazy(() => import('./HeavyComponent'));
const ChatWidget = lazy(() => import('./chat'));

// Load analytics after page interactive
if (typeof window !== 'undefined') {
  window.addEventListener('load', () => {
    import('./analytics').then(({ Analytics }) => {
      Analytics.init();
    });
  });
}
\`\`\`

2. **Remove Unused Dependencies:**
\`\`\`bash
# Analyze bundle
npx webpack-bundle-analyzer

# Remove unused packages
npm uninstall moment  # Use date-fns instead (smaller)
npm install date-fns
\`\`\`

3. **Defer Non-Critical Scripts:**
\`\`\`html
<!-- Before: Blocks rendering -->
<script src="/analytics.js"></script>

<!-- After: Deferred -->
<script src="/analytics.js" defer></script>
\`\`\`

#### Fix CLS (Cumulative Layout Shift)

**Problem:** Images without dimensions cause layout shifts

**Solutions:**
\`\`\`html
<!-- Before: No dimensions -->
<img src="/product.jpg" alt="Product">

<!-- After: With dimensions -->
<img
  src="/product.jpg"
  alt="Product"
  width="400"
  height="300"
  style="aspect-ratio: 4/3;"
>
\`\`\`

**For dynamic content:**
\`\`\`css
/* Reserve space for content that loads later */
.skeleton-loader {
  min-height: 200px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
\`\`\`

### Results After Optimization

- **LCP:** 1.8s ✅ (improved by 57%)
- **INP:** 75ms ✅ (improved by 58%)
- **CLS:** 0.05 ✅ (improved by 80%)
- **Lighthouse Score:** 94/100 ✅
```

> Historical note: Some older reports and dashboards still show FID. For current optimization work, prioritize INP.

### Example 2: Reducing JavaScript Bundle Size

```markdown
## Bundle Size Optimization

### Current State
- **Total Bundle:** 850KB (gzipped: 280KB)
- **Main Bundle:** 650KB
- **Vendor Bundle:** 200KB
- **Load Time (3G):** 8.2s

### Analysis

\`\`\`bash
# Analyze bundle composition
npx webpack-bundle-analyzer dist/stats.json
\`\`\`

**Findings:**
1. Moment.js: 67KB (can replace with date-fns: 12KB)
2. Lodash: 72KB (using entire library, only need 5 functions)
3. Unused code: ~150KB of dead code
4. No code splitting: Everything in one bundle

### Optimization Steps

#### 1. Replace Heavy Dependencies

\`\`\`bash
# Remove moment.js (67KB) → Use date-fns (12KB)
npm uninstall moment
npm install date-fns

# Before
import moment from 'moment';
const formatted = moment(date).format('YYYY-MM-DD');

# After
import { format } from 'date-fns';
const formatted = format(date, 'yyyy-MM-dd');
\`\`\`

**Savings:** 55KB

#### 2. Use Lodash Selectively

\`\`\`javascript
// Before: Import entire library (72KB)
import _ from 'lodash';
const unique = _.uniq(array);

// After: Import only what you need (5KB)
import uniq from 'lodash/uniq';
const unique = uniq(array);

// Or use native methods
const unique = [...new Set(array)];
\`\`\`

**Savings:** 67KB

#### 3. Implement Code Splitting

\`\`\`javascript
// Next.js example
import dynamic from 'next/dynamic';

// Lazy load heavy components
const Chart = dynamic(() => import('./Chart'), {
  loading: () => <div>Loading chart...</div>,
  ssr: false
});

const AdminPanel = dynamic(() => import('./AdminPanel'), {
  loading: () => <div>Loading...</div>
});

// Route-based code splitting (automatic in Next.js)
// pages/admin.js - Only loaded when visiting /admin
// pages/dashboard.js - Only loaded when visiting /dashboard
\`\`\`

#### 4. Remove Dead Code

\`\`\`javascript
// Enable tree shaking in webpack.config.js
module.exports = {
  mode: 'production',
  optimization: {
    usedExports: true
  }
};

// Set sideEffects only when package truly has no side-effectful imports.
// If needed, keep explicit allowlist for CSS/polyfills/initializers.
// package.json example:
// {
//   "sideEffects": ["*.css", "./src/polyfills.js", "./src/monitoring/init.js"]
// }
\`\`\`

#### 5. Optimize Third-Party Scripts

\`\`\`html
<!-- Before: Loads immediately -->
<script src="https://analytics.com/script.js"></script>

<!-- After: Deferred + integrity + policy controls -->
<script
  src="https://analytics.com/script.v123.js"
  defer
  integrity="sha384-..."
  crossorigin="anonymous"
  referrerpolicy="strict-origin-when-cross-origin"
></script>

<!-- Option: Load after consent and page interactive -->
<script>
  window.addEventListener('load', async () => {
    const consentGranted = await getAnalyticsConsent();
    if (!consentGranted) return;

    const script = document.createElement('script');
    script.src = 'https://analytics.com/script.v123.js';
    script.async = true;
    script.nonce = window.__CSP_NONCE__;
    document.body.appendChild(script);
  });
</script>
\`\`\`

Security and governance notes:
- Pin vendor script version when possible (avoid mutable URLs).
- Use CSP allowlists/nonces and SRI for third-party code.
- Confirm consent, privacy, and data-retention requirements before enabling tracking.

### Results

- **Total Bundle:** 380KB ✅ (reduced by 55%)
- **Main Bundle:** 180KB ✅
- **Vendor Bundle:** 80KB ✅
- **Load Time (3G):** 3.1s ✅ (improved by 62%)
```

### Example 3: Image Optimization Strategy

```markdown
## Image Optimization

### Current Issues
- 15 images totaling 12MB
- No modern formats (WebP, AVIF)
- No responsive images
- No lazy loading

### Optimization Strategy

#### 1. Convert to Modern Formats

\`\`\`bash
# Install image optimization tools
npm install sharp

\`\`\`

\`\`\`javascript
const fs = require('fs/promises');
const path = require('path');
const sharp = require('sharp');

const INPUT_DIR = './images';
const OUTPUT_DIR = './images/optimized';
const ALLOWED_EXTENSIONS = new Set(['.jpg', '.jpeg', '.png', '.webp', '.avif']);

// Conversion script (optimize-images.js)

async function optimizeImage(inputPath, outputDir) {
  const filename = path.basename(inputPath, path.extname(inputPath));

  // Generate WebP
  await sharp(inputPath)
    .webp({ quality: 80 })
    .toFile(path.join(outputDir, \`\${filename}.webp\`));

  // Generate AVIF (best compression)
  await sharp(inputPath)
    .avif({ quality: 70 })
    .toFile(path.join(outputDir, \`\${filename}.avif\`));

  // Generate optimized JPEG fallback
  await sharp(inputPath)
    .jpeg({ quality: 80, progressive: true })
    .toFile(path.join(outputDir, \`\${filename}.jpg\`));
}

async function main() {
  await fs.mkdir(OUTPUT_DIR, { recursive: true });
  const files = await fs.readdir(INPUT_DIR);

  const images = files.filter((file) =>
    ALLOWED_EXTENSIONS.has(path.extname(file).toLowerCase())
  );

  await Promise.all(
    images.map(async (file) => {
      const inputPath = path.join(INPUT_DIR, file);
      try {
        await optimizeImage(inputPath, OUTPUT_DIR);
      } catch (error) {
        console.error(`Failed to optimize ${file}:`, error.message);
      }
    })
  );
}

main().catch((error) => {
  console.error('Image optimization failed:', error.message);
  process.exitCode = 1;
});
\`\`\`

#### 2. Implement Responsive Images

\`\`\`html
<!-- Responsive images with modern formats -->
<picture>
  <!-- AVIF for browsers that support it (best compression) -->
  <source
    srcset="
      /images/hero-400.avif 400w,
      /images/hero-800.avif 800w,
      /images/hero-1200.avif 1200w
    "
    type="image/avif"
    sizes="(max-width: 768px) 100vw, 50vw"
  >

  <!-- WebP for browsers that support it -->
  <source
    srcset="
      /images/hero-400.webp 400w,
      /images/hero-800.webp 800w,
      /images/hero-1200.webp 1200w
    "
    type="image/webp"
    sizes="(max-width: 768px) 100vw, 50vw"
  >

  <!-- JPEG fallback -->
  <img
    src="/images/hero-800.jpg"
    srcset="
      /images/hero-400.jpg 400w,
      /images/hero-800.jpg 800w,
      /images/hero-1200.jpg 1200w
    "
    sizes="(max-width: 768px) 100vw, 50vw"
    alt="Hero image"
    width="1200"
    height="600"
    loading="lazy"
  >
</picture>
\`\`\`

#### 3. Lazy Loading

\`\`\`html
<!-- Native lazy loading -->
<img
  src="/image.jpg"
  alt="Description"
  loading="lazy"
  width="800"
  height="600"
>

<!-- Eager loading for above-the-fold images -->
<img
  src="/hero.jpg"
  alt="Hero"
  loading="eager"
  fetchpriority="high"
>
\`\`\`

Guidance:
- Do not lazy-load likely LCP elements (hero image, main heading media, near-viewport content).
- Use lazy loading for below-the-fold and non-critical assets.

#### 4. Next.js Image Component

\`\`\`javascript
import Image from 'next/image';

// Automatic optimization
<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority  // For above-the-fold images
  quality={80}
/>

// Lazy loaded
<Image
  src="/product.jpg"
  alt="Product"
  width={400}
  height={300}
  loading="lazy"
/>
\`\`\`

### Results

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Total Image Size | 12MB | 1.8MB | 85% reduction |
| LCP | 4.5s | 1.6s | 64% faster |
| Page Load (3G) | 18s | 4.2s | 77% faster |
```

## Best Practices

### ✅ Do This

- **Measure First** - Always establish baseline metrics before optimizing
- **Use Lighthouse** - Run audits regularly to track progress
- **Optimize Images** - Use modern formats (WebP, AVIF) and responsive images
- **Code Split** - Break large bundles into smaller chunks
- **Lazy Load** - Defer non-critical resources
- **Cache Aggressively** - Set proper cache headers for static assets
- **Minimize Main Thread Work** - Keep JavaScript execution under 50ms chunks
- **Preload Critical Resources** - Use `<link rel="preload">` for critical assets
- **Use CDN** - Serve static assets from CDN for faster delivery
- **Monitor Real Users** - Track Core Web Vitals from real users
- **Harden Third-Party Scripts** - Use CSP, SRI, and consent checks for external scripts
- **Redact Telemetry** - Remove PII/secrets from analytics and monitoring payloads

### ❌ Don't Do This

- **Don't Optimize Blindly** - Measure first, then optimize
- **Don't Ignore Mobile** - Test on real mobile devices and slow networks
- **Don't Block Rendering** - Avoid render-blocking CSS and JavaScript
- **Don't Load Everything Upfront** - Lazy load non-critical resources
- **Don't Forget Dimensions** - Always specify image width/height
- **Don't Use Synchronous Scripts** - Use async or defer attributes
- **Don't Ignore Third-Party Scripts** - They often cause performance issues
- **Don't Skip Compression** - Always compress and minify assets
- **Don't Cache Sensitive Data Blindly** - Avoid caching authenticated/private responses in service workers by default

## Security and Privacy Notes

- Prefer strict Content Security Policy (CSP) with explicit script sources and nonces.
- Do not cache auth tokens, PII, or sensitive API responses in service workers unless requirements and controls are explicit.
- Configure analytics/APM tools to redact query strings, headers, identifiers, and user-generated content where possible.
- Validate third-party script governance: version pinning, integrity checks, and vendor trust review.

## Common Pitfalls

### Problem: Optimized for Desktop but Slow on Mobile
**Symptoms:** Good Lighthouse score on desktop, poor on mobile
**Solution:**
- Test on real mobile devices
- Use Chrome DevTools mobile throttling
- Optimize for 3G/4G networks
- Reduce JavaScript execution time
```bash
# Test with throttling
lighthouse https://yoursite.com --throttling.cpuSlowdownMultiplier=4
```

### Problem: Large JavaScript Bundle
**Symptoms:** Long Time to Interactive (TTI), poor responsiveness (high INP)
**Solution:**
- Analyze bundle with webpack-bundle-analyzer
- Remove unused dependencies
- Implement code splitting
- Lazy load non-critical code
```bash
# Analyze bundle
npx webpack-bundle-analyzer dist/stats.json
```

### Problem: Images Causing Layout Shifts
**Symptoms:** High CLS score, content jumping
**Solution:**
- Always specify width and height
- Use aspect-ratio CSS property
- Reserve space with skeleton loaders
```css
img {
  aspect-ratio: 16 / 9;
  width: 100%;
  height: auto;
}
```

### Problem: Slow Server Response Time
**Symptoms:** High TTFB (Time to First Byte)
**Solution:**
- Implement server-side caching
- Use CDN for static assets
- Optimize database queries
- Consider static site generation (SSG)
```javascript
// Next.js: Static generation
export async function getStaticProps() {
  const data = await fetchData();
  return {
    props: { data },
    revalidate: 60 // Regenerate every 60 seconds
  };
}
```

## Performance Checklist

### Images
- [ ] Convert to modern formats (WebP, AVIF)
- [ ] Implement responsive images
- [ ] Add lazy loading
- [ ] Specify dimensions (width/height)
- [ ] Compress images (< 200KB each)
- [ ] Use CDN for delivery

### JavaScript
- [ ] Bundle size < 200KB (gzipped)
- [ ] Implement code splitting
- [ ] Lazy load non-critical code
- [ ] Remove unused dependencies
- [ ] Minify and compress
- [ ] Use async/defer for scripts

### CSS
- [ ] Inline critical CSS
- [ ] Defer non-critical CSS
- [ ] Remove unused CSS
- [ ] Minify CSS files
- [ ] Use CSS containment

### Caching
- [ ] Set cache headers for static assets
- [ ] Implement service worker with explicit cache boundaries
- [ ] Use CDN caching
- [ ] Cache API responses by sensitivity (public vs authenticated/private)
- [ ] Version static assets
- [ ] Avoid caching tokens/PII/sensitive responses by default

### Core Web Vitals (field targets; use as heuristics)
- [ ] LCP < 2.5s
- [ ] INP < 200ms
- [ ] CLS < 0.1
- [ ] TTFB < 800ms (context-dependent)
- [ ] TTI trend improving (lab signal; less critical than CWV)

## Performance Tools

### Measurement Tools
- **Lighthouse** - Comprehensive performance audit
- **WebPageTest** - Detailed waterfall analysis
- **Chrome DevTools** - Performance profiling
- **PageSpeed Insights** - Real user metrics
- **Web Vitals Extension** - Monitor Core Web Vitals

### Analysis Tools
- **webpack-bundle-analyzer** - Visualize bundle composition
- **source-map-explorer** - Analyze bundle size
- **Bundlephobia** - Check package sizes before installing
- **ImageOptim** - Image compression tool

### Monitoring Tools
- **Google Analytics** - Track Core Web Vitals
- **Sentry** - Performance monitoring
- **New Relic** - Application performance monitoring
- **Datadog** - Real user monitoring

Privacy note: configure telemetry scrubbing/redaction before sending production traffic.

## Related Skills

- `@react-tailwind` - React performance and frontend implementation patterns
- `@performance-analysis` - Bottleneck and optimization trade-off analysis
- `@software-architect` - Architecture decisions for performance and reliability
- `@software-engineer` - Pragmatic implementation, testing, and delivery guidance

## Additional Resources

- [Web.dev Performance](https://web.dev/performance/)
- [Core Web Vitals](https://web.dev/vitals/)
- [Lighthouse Documentation](https://developers.google.com/web/tools/lighthouse)
- [MDN Performance Guide](https://developer.mozilla.org/en-US/docs/Web/Performance)
- [Next.js Performance](https://nextjs.org/docs/advanced-features/measuring-performance)
- [Image Optimization Guide](https://web.dev/fast/#optimize-your-images)

---

**Pro Tip:** Focus on Core Web Vitals (LCP, INP, CLS) first - they have biggest impact on user experience and SEO rankings. Mention FID only for historical dashboard context.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.
