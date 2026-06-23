import { Pool } from "https://deno.land/x/postgres@v0.17.0/mod.ts";

const SUPABASE_DB_URL = Deno.env.get("SUPABASE_DB_URL");
if (!SUPABASE_DB_URL) throw new Error("SUPABASE_DB_URL is required");

// One connection is enough for simple RPC lookups
const pool = new Pool(SUPABASE_DB_URL, 1);

Deno.serve(async (req: Request) => {
  if (req.method !== "POST") {
    return new Response(
      JSON.stringify({ error: "Use POST with JSON body { lat, lng }" }),
      {
        status: 405,
        headers: { "Content-Type": "application/json" },
      },
    );
  }

  let body: any;
  try {
    body = await req.json();
  } catch {
    return new Response(JSON.stringify({ error: "Invalid JSON body" }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }

  const lat = Number(body?.lat);
  const lng = Number(body?.lng);

  if (!Number.isFinite(lat) || !Number.isFinite(lng)) {
    return new Response(
      JSON.stringify({ error: "lat and lng must be numbers" }),
      {
        status: 400,
        headers: { "Content-Type": "application/json" },
      },
    );
  }

  const connection = await pool.connect();
  try {
    // Assumes you have a Postgres function named `resolve_coordinates(lat, lng)`.
    // If your function has a different signature, update the SQL call accordingly.
    const result = await connection.queryObject<{ result: unknown }>`
      SELECT public.resolve_coordinate(${lat}, ${lng}) as result
    `;

    return new Response(
      JSON.stringify({ ...(result.rows[0]?.result ?? null) }),
      { headers: { "Content-Type": "application/json" } },
    );
  } catch (e) {
    console.error(e);
    return new Response(
      JSON.stringify({ error: (e as Error).message ?? String(e) }),
      {
        status: 500,
        headers: { "Content-Type": "application/json" },
      },
    );
  } finally {
    connection.release();
  }
});
