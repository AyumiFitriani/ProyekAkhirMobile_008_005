const express = require('express');
const app = express();
const cors = require('cors');
app.use(cors());

// Data buku awal
const books = [
    {
        id: 'BK001',
        title: 'Bulan',
        tahunTerbit: '2019',
        authorName: 'Tere Liye',
        cover: 'assets/bulan.jpg',
        review: '5/5',
        sinopsis: 'Petualangan Raib, Ali dan Seli berlanjut di dunia paralel'
    },
    {
        id: 'BK002',
        title: 'Matahari',
        tahunTerbit: '2020',
        authorName: 'Tere Liye',
        cover: 'assets/matahari.jpg',
        review: '4.8/5',
        sinopsis: 'Kisah persahabatan yang mengharukan'
    },
    {
        id: 'BK003',
        title: 'Bintang',
        tahunTerbit: '2018',
        authorName: 'Tere Liye',
        cover: 'assets/bintang.jpg',
        review: '4.9/5',
        sinopsis: 'Petualangan mencari portal tersembunyi'
    },
    {
        id: 'BK004',
        title: 'Komet',
        tahunTerbit: '2021',
        authorName: 'Tere Liye',
        cover: 'assets/komet.jpg',
        review: '4.7/5',
        sinopsis: 'Melanjutkan petualangan di dunia paralel'
    },
    {
        id: 'BK005',
        title: 'Bumi',
        tahunTerbit: '2017',
        authorName: 'Tere Liye',
        cover: 'assets/bumi.jpg',
        review: '5/5',
        sinopsis: 'Awal mula petualangan Raib'
    },
    {
        id: 'BK006',
        title: 'Laskar Pelangi',
        tahunTerbit: '2005',
        authorName: 'Andrea Hirata',
        cover: 'assets/laskar_pelangi.jpg',
        review: '5/5',
        sinopsis: 'Perjuangan anak-anak Belitung mengejar pendidikan'
    },
    {
        id: 'BK007',
        title: 'Sang Pemimpi',
        tahunTerbit: '2006',
        authorName: 'Andrea Hirata',
        cover: 'assets/sang_pemimpi.jpg',
        review: '4.8/5',
        sinopsis: 'Kisah persahabatan dan mimpi yang tinggi'
    },
    {
        id: 'BK008',
        title: 'Edensor',
        tahunTerbit: '2007',
        authorName: 'Andrea Hirata',
        cover: 'assets/edensor.jpg',
        review: '4.7/5',
        sinopsis: 'Petualangan di benua Eropa'
    },
    {
        id: 'BK009',
        title: 'Negeri 5 Menara',
        tahunTerbit: '2009',
        authorName: 'Ahmad Fuadi',
        cover: 'assets/negeri5menara.jpg',
        review: '4.9/5',
        sinopsis: 'Kisah santri di pondok Madani'
    },
    {
        id: 'BK010',
        title: 'Ranah 3 Warna',
        tahunTerbit: '2011',
        authorName: 'Ahmad Fuadi',
        cover: 'assets/ranah3warna.jpg',
        review: '4.8/5',
        sinopsis: 'Petualangan mengejar mimpi hingga ke negeri Kanada'
    }
];

// Daftar nama file gambar yang tersedia di folder "assets"
const availableCovers = [
    'assets/bulan.jpg',
    'assets/matahari.jpg',
    'assets/bintang.jpg',
    'assets/komet.jpg',
    'assets/bumi.jpg',
    'assets/laskar_pelangi.jpg',
    'assets/sang_pemimpi.jpg',
    'assets/edensor.jpg',
    'assets/negeri5menara.jpg',
    'assets/ranah3warna.jpg',
];

// Generate 190 buku tambahan
for (let i = 11; i <= 200; i++) {
    const id = `BK${i.toString().padStart(3, '0')}`;
    const bookTypes = ['Novel', 'Komik', 'Biografi', 'Sejarah', 'Sains', 'Teknologi'];
    const authors = ['Pramoedya Ananta Toer', 'Dee Lestari', 'Eka Kurniawan', 'Leila S. Chudori', 'Asma Nadia', 'Boy Candra'];
    const randomType = bookTypes[Math.floor(Math.random() * bookTypes.length)];
    const randomAuthor = authors[Math.floor(Math.random() * authors.length)];
    const randomYear = Math.floor(Math.random() * (2024 - 2000 + 1)) + 2000; // Tahun antara 2000-2024

    // Pilih gambar cover berdasarkan indeks
    const cover = availableCovers[(i - 1) % availableCovers.length];

    books.push({
        id: id,
        title: `${randomType} ${i}`,
        tahunTerbit: randomYear.toString(),
        authorName: randomAuthor,
        cover: cover,
        review: `${(Math.random() * (5 - 3) + 3).toFixed(1)}/5`,
        sinopsis: `Sinopsis untuk buku ${randomType} nomor ${i}`
    });
}

// Endpoint untuk mendapatkan semua buku
app.get('/books', (req, res) => {
    res.json(books);
});

// Endpoint untuk mendapatkan buku berdasarkan ID
app.get('/book/:id', (req, res) => {
    const book = books.find(b => b.id === req.params.id);
    if (book) {
        res.json(book);
    } else {
        res.status(404).json({ message: 'Buku tidak ditemukan' });
    }
});

// Endpoint untuk mencari buku berdasarkan judul
app.get('/book/search/:title', (req, res) => {
    const searchResults = books.filter(book =>
        book.title.toLowerCase().includes(req.params.title.toLowerCase())
    );
    res.json(searchResults);
});

// Endpoint untuk mencari buku berdasarkan tahun terbit
app.get('/book/year/:year', (req, res) => {
    const searchResults = books.filter(book =>
        book.tahunTerbit === req.params.year
    );
    res.json(searchResults);
});

const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
