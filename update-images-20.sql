-- Updates cover keys to match seed/cover/quant-01..quant-20 in S3.
SET @i:=0;
UPDATE channel
SET cover = ELT((@i:=@i+1) % 20 + 1,
  'seed/cover/quant-01.jpg',
  'seed/cover/quant-02.jpg',
  'seed/cover/quant-03.jpg',
  'seed/cover/quant-04.jpg',
  'seed/cover/quant-05.jpg',
  'seed/cover/quant-06.jpg',
  'seed/cover/quant-07.jpg',
  'seed/cover/quant-08.jpg',
  'seed/cover/quant-09.jpg',
  'seed/cover/quant-10.jpg',
  'seed/cover/quant-11.jpg',
  'seed/cover/quant-12.jpg',
  'seed/cover/quant-13.jpg',
  'seed/cover/quant-14.jpg',
  'seed/cover/quant-15.jpg',
  'seed/cover/quant-16.jpg',
  'seed/cover/quant-17.jpg',
  'seed/cover/quant-18.jpg',
  'seed/cover/quant-19.jpg',
  'seed/cover/quant-20.jpg'
);

SET @j:=0;
UPDATE channel_section
SET cover = ELT((@j:=@j+1) % 20 + 1,
  'seed/cover/quant-01.jpg',
  'seed/cover/quant-02.jpg',
  'seed/cover/quant-03.jpg',
  'seed/cover/quant-04.jpg',
  'seed/cover/quant-05.jpg',
  'seed/cover/quant-06.jpg',
  'seed/cover/quant-07.jpg',
  'seed/cover/quant-08.jpg',
  'seed/cover/quant-09.jpg',
  'seed/cover/quant-10.jpg',
  'seed/cover/quant-11.jpg',
  'seed/cover/quant-12.jpg',
  'seed/cover/quant-13.jpg',
  'seed/cover/quant-14.jpg',
  'seed/cover/quant-15.jpg',
  'seed/cover/quant-16.jpg',
  'seed/cover/quant-17.jpg',
  'seed/cover/quant-18.jpg',
  'seed/cover/quant-19.jpg',
  'seed/cover/quant-20.jpg'
);
