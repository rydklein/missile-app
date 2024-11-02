-- CreateTable
CREATE TABLE "Game" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Object" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "ownerId" INTEGER NOT NULL,

    CONSTRAINT "Object_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_UserGames" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_GameObjects" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_UserGames_AB_unique" ON "_UserGames"("A", "B");

-- CreateIndex
CREATE INDEX "_UserGames_B_index" ON "_UserGames"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_GameObjects_AB_unique" ON "_GameObjects"("A", "B");

-- CreateIndex
CREATE INDEX "_GameObjects_B_index" ON "_GameObjects"("B");

-- AddForeignKey
ALTER TABLE "Object" ADD CONSTRAINT "Object_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserGames" ADD CONSTRAINT "_UserGames_A_fkey" FOREIGN KEY ("A") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserGames" ADD CONSTRAINT "_UserGames_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameObjects" ADD CONSTRAINT "_GameObjects_A_fkey" FOREIGN KEY ("A") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameObjects" ADD CONSTRAINT "_GameObjects_B_fkey" FOREIGN KEY ("B") REFERENCES "Object"("id") ON DELETE CASCADE ON UPDATE CASCADE;
