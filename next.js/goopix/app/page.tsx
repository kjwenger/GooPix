import Link from 'next/link';

export default function Home() {
  return (
    <main className="container mx-auto p-8">
      <h1 className="text-3xl font-bold mb-8">Welcome to Goopix</h1>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {/* Photo grid will go here once we implement Google Photos API */}
        <p>Please log in to view your photos</p>
        <Link 
          href="/login"
          className="text-blue-500 hover:text-blue-700"
        >
          Login with Google Photos
        </Link>
      </div>
    </main>
  );
}
