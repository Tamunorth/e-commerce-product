const CRAWLER_USER_AGENTS = [
  'facebookexternalhit',
  'Facebot',
  'Twitterbot',
  'LinkedInBot',
  'Slackbot',
  'Discordbot',
  'WhatsApp',
  'TelegramBot',
  'Googlebot',
  'bingbot',
  'Applebot',
];

function isCrawler(userAgent: string | null): boolean {
  if (!userAgent) return false;
  return CRAWLER_USER_AGENTS.some((bot) =>
    userAgent.toLowerCase().includes(bot.toLowerCase())
  );
}

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

export default async function handler(request: Request) {
  const userAgent = request.headers.get('user-agent');

  if (!isCrawler(userAgent)) {
    return;
  }

  const url = new URL(request.url);
  const segments = url.pathname.split('/').filter(Boolean);

  // Match /products/:id
  if (segments.length !== 2 || segments[0] !== 'products') {
    return;
  }

  const productId = segments[1];
  if (!/^\d+$/.test(productId)) {
    return;
  }

  try {
    const apiResponse = await fetch(
      `https://dummyjson.com/products/${productId}`
    );

    if (!apiResponse.ok) {
      return;
    }

    const product = await apiResponse.json();
    const title = escapeHtml(product.title ?? 'Product');
    const description = escapeHtml(
      product.description ?? 'View this product on Product Catalog.'
    );
    const image = escapeHtml(product.thumbnail ?? '');
    const price = product.price
      ? `$${Number(product.price).toFixed(2)}`
      : '';

    const html = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${title} - Product Catalog</title>
  <meta name="description" content="${description}">
  <meta property="og:type" content="product">
  <meta property="og:title" content="${title}">
  <meta property="og:description" content="${description}${price ? ` - ${escapeHtml(price)}` : ''}">
  <meta property="og:image" content="${image}">
  <meta property="og:url" content="${escapeHtml(url.toString())}">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${title}">
  <meta name="twitter:description" content="${description}">
  <meta name="twitter:image" content="${image}">
</head>
<body></body>
</html>`;

    return new Response(html, {
      headers: { 'content-type': 'text/html; charset=utf-8' },
    });
  } catch {
    return;
  }
}
