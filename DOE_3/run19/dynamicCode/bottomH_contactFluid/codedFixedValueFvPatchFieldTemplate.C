/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Copyright (C) YEAR OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "codedFixedValueFvPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"
#include "unitConversion.H"
//{{{ begin codeInclude

//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

extern "C"
{
    // dynamicCode:
    // SHA1 = 15b51cf686c74d072b01e897f536427b45a705e2
    //
    // unique function name that can be checked if the correct library version
    // has been loaded
    void bottomH_contactFluid_15b51cf686c74d072b01e897f536427b45a705e2(bool load)
    {
        if (load)
        {
            // code that can be explicitly executed after loading
        }
        else
        {
            // code that can be explicitly executed before unloading
        }
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchScalarField,
    bottomH_contactFluidFixedValueFvPatchScalarField
);


const char* const bottomH_contactFluidFixedValueFvPatchScalarField::SHA1sum =
    "15b51cf686c74d072b01e897f536427b45a705e2";


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

bottomH_contactFluidFixedValueFvPatchScalarField::
bottomH_contactFluidFixedValueFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF
)
:
    fixedValueFvPatchField<scalar>(p, iF)
{
    if (false)
    {
        Info<<"construct bottomH_contactFluid sha1: 15b51cf686c74d072b01e897f536427b45a705e2"
            " from patch/DimensionedField\n";
    }
}


bottomH_contactFluidFixedValueFvPatchScalarField::
bottomH_contactFluidFixedValueFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const dictionary& dict
)
:
    fixedValueFvPatchField<scalar>(p, iF, dict)
{
    if (false)
    {
        Info<<"construct bottomH_contactFluid sha1: 15b51cf686c74d072b01e897f536427b45a705e2"
            " from patch/dictionary\n";
    }
}


bottomH_contactFluidFixedValueFvPatchScalarField::
bottomH_contactFluidFixedValueFvPatchScalarField
(
    const bottomH_contactFluidFixedValueFvPatchScalarField& ptf,
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fixedValueFvPatchField<scalar>(ptf, p, iF, mapper)
{
    if (false)
    {
        Info<<"construct bottomH_contactFluid sha1: 15b51cf686c74d072b01e897f536427b45a705e2"
            " from patch/DimensionedField/mapper\n";
    }
}


bottomH_contactFluidFixedValueFvPatchScalarField::
bottomH_contactFluidFixedValueFvPatchScalarField
(
    const bottomH_contactFluidFixedValueFvPatchScalarField& ptf,
    const DimensionedField<scalar, volMesh>& iF
)
:
    fixedValueFvPatchField<scalar>(ptf, iF)
{
    if (false)
    {
        Info<<"construct bottomH_contactFluid sha1: 15b51cf686c74d072b01e897f536427b45a705e2 "
            "as copy/DimensionedField\n";
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

bottomH_contactFluidFixedValueFvPatchScalarField::
~bottomH_contactFluidFixedValueFvPatchScalarField()
{
    if (false)
    {
        Info<<"destroy bottomH_contactFluid sha1: 15b51cf686c74d072b01e897f536427b45a705e2\n";
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void bottomH_contactFluidFixedValueFvPatchScalarField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        Info<<"updateCoeffs bottomH_contactFluid sha1: 15b51cf686c74d072b01e897f536427b45a705e2\n";
    }

//{{{ begin code
    #line 23 "/home/rico-reiser/freezeCase/freezeFoam2/freezeValidation/Lit-2.1/0/h.contactFluid/boundaryField/bottom"
const fvPatch& patch = this->patch();
        const fvMesh&  mesh  = patch.boundaryMesh().mesh();

        scalarField& hPatch = *this;

        const scalar Twall = 253.15;     // Wandtemperatur
        const scalar cpRef = 2300.0;     // konstantes cp (z.B. cpLiquid)

        // Tref direkt aus solidificationProperties lesen
        IOdictionary solidProps
        (
            IOobject
            (
                "solidificationProperties",
                "constant",
                mesh,
                IOobject::MUST_READ,
                IOobject::NO_WRITE
            )
        );

        const scalar Tref = readScalar(solidProps.lookup("Tref"));

        forAll(hPatch, faceI)
        {
            hPatch[faceI] = cpRef*(Twall - Tref);
        }
//}}} end code

    this->fixedValueFvPatchField<scalar>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

