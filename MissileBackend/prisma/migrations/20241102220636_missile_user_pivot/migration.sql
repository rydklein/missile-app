-- CreateTable
CREATE TABLE "MissileRange" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "missileId" INTEGER NOT NULL,
    "inRange" BOOLEAN NOT NULL,

    CONSTRAINT "MissileRange_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "MissileRange_userId_missileId_key" ON "MissileRange"("userId", "missileId");

-- AddForeignKey
ALTER TABLE "MissileRange" ADD CONSTRAINT "MissileRange_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MissileRange" ADD CONSTRAINT "MissileRange_missileId_fkey" FOREIGN KEY ("missileId") REFERENCES "Object"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
