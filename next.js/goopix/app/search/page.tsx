export default function Search() {
  return (
    <main className="container mx-auto p-8">
      <h1 className="text-2xl font-bold mb-8">Search Photos</h1>
      <input 
        type="search" 
        placeholder="Search your photos..."
        className="w-full max-w-md px-4 py-2 border rounded-lg"
      />
      {/* Search results will go here */}
    </main>
  );
} 