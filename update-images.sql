SET @i:=0;
UPDATE channel
SET cover = ELT((@i:=@i+1) % 6 + 1,
  'seed/cover/quant-1.jpg',
  'seed/cover/quant-2.jpg',
  'seed/cover/quant-3.jpg',
  'seed/cover/quant-4.jpg',
  'seed/cover/quant-5.jpg',
  'seed/cover/quant-6.jpg'
);

SET @j:=0;
UPDATE channel_section
SET cover = ELT((@j:=@j+1) % 6 + 1,
  'seed/cover/quant-1.jpg',
  'seed/cover/quant-2.jpg',
  'seed/cover/quant-3.jpg',
  'seed/cover/quant-4.jpg',
  'seed/cover/quant-5.jpg',
  'seed/cover/quant-6.jpg'
);

SET @k:=0;
UPDATE user_info
SET avatar = ELT((@k:=@k+1) % 3 + 1,
  'seed/avatar/user-1.jpg',
  'seed/avatar/user-2.jpg',
  'seed/avatar/user-3.jpg'
);
