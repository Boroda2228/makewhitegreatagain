import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Button, NumberInput, Section } from '../components';
import { Window } from '../layouts';

type Data = {
  amount: number;
  purity: number;
  beakerCurrentVolume: number;
  beakerMaxVolume: number;
  isBeakerLoaded: BooleanLike;
  beakerContents: { name: string; volume: number }[];
};

export const ChemDebugSynthesizer = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    amount,
    purity,
    beakerCurrentVolume,
    beakerMaxVolume,
    isBeakerLoaded,
    beakerContents = [],
  } = data;

  return (
    <Window width={390} height={330}>
      <Window.Content scrollable>
        <Section
          title="Recipient"
          buttons={
            isBeakerLoaded ? (
              <>
                <Button
                  icon="eject"
                  content="Eject"
                  onClick={() => act('ejectBeaker')}
                />
                <NumberInput
                  value={amount}
                  unit="u"
                  minValue={1}
                  maxValue={beakerMaxVolume}
                  step={1}
                  stepPixelSize={2}
                  onChange={(e, value) =>
                    act('amount', {
                      amount: value,
                    })
                  }
                />
                <NumberInput
                  value={purity}
                  unit="%"
                  minValue={0}
                  maxValue={120}
                  step={1}
                  stepPixelSize={2}
                  onChange={(e, value) =>
                    act('purity', {
                      amount: value,
                    })
                  }
                />
                <Button
                  icon="plus"
                  content="Input"
                  onClick={() => act('input')}
                />
              </>
            ) : (
              <Button
                icon="plus"
                content="Create Beaker"
                onClick={() => act('makecup')}
              />
            )
          }
        >
          <BeakerDisplay beaker={beaker} showpH />
        </Section>
      </Window.Content>
    </Window>
  );
};
